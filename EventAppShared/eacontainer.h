#ifndef EVENTCONTAINER_H
#define EVENTCONTAINER_H
#include <QString>
#include <QQuickItem>
#include <QCoreApplication>
#include "eventappshared_global.h"

class EAInfo;
class EAConstruction;
class EAItemList;
//enum SaveFormat {Json, Binary };

static const QString EVENT ="event";
static const QString CONSTRUCTION ="construction";
static const QString SPEAKERS ="speakers";

//class EVENTAPPSHAREDSHARED_EXPORT EAContainer : public QQuickItem
class  EAContainer : public QObject, public QQmlParserStatus
{
    Q_OBJECT
    Q_INTERFACES(QQmlParserStatus)
    Q_PROPERTY(EAInfo* eaInfo READ eaInfo WRITE setEAInfo NOTIFY eaInfoChanged)
    Q_PROPERTY(EAConstruction* eaConstruction READ eaConstruction WRITE setEAConstruction NOTIFY eaConstructionChanged)
    Q_PROPERTY(EAItemList* eaSpeakers READ eaSpeakers WRITE setEaSpeakers NOTIFY eaSpeakersChanged)

    Q_PROPERTY(QQmlListProperty<EAItemList> eaItemLists READ eaItemLists)

    Q_PROPERTY(QString workingDirectory READ workingDirectory WRITE setWorkingDirectory NOTIFY workingDirectoryChanged)
    Q_PROPERTY(QString dataFilename READ dataFilename WRITE setDataFilename NOTIFY dataFilenameChanged)
    Q_PROPERTY(bool isSaveJson READ isSaveJson WRITE setIsSaveJson NOTIFY isSaveJsonChanged)

    EAInfo* m_eaInfo;
    QString m_dataFilename;
    EAConstruction* m_eaConstruction;
    bool m_isSaveJson = true;
    QString m_workingDirectory = QCoreApplication::applicationDirPath();    
    EAItemList* m_eaSpeakers;
    QList<EAItemList*> m_eaItemLists;

public:
    EAContainer();

    virtual void classBegin();
    virtual void componentComplete();

    Q_INVOKABLE  bool loadEventApp();
    Q_INVOKABLE  bool saveSaveEventApp() const;
    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;
    QString workingDirectory() const;


    EAInfo* eaInfo() const;
    QString dataFilename() const;
    EAConstruction* eaConstruction() const;
    bool isSaveJson() const;    
    EAItemList* eaSpeakers() const;
    QQmlListProperty<EAItemList> eaItemLists();

signals:
    void eaInfoChanged(EAInfo* eaInfo);
    void dataFilenameChanged(QString dataFilename);
    void eaConstructionChanged(EAConstruction* eaConstruction);
    void isSaveJsonChanged(bool isSaveJson);
    void eaComponentComplete();
    void workingDirectoryChanged(QString workingDirectory);

    void eaSpeakersChanged(EAItemList* eaSpeakers);

public slots:
    void setEAInfo(EAInfo* eaInfo);
    void setDataFilename(QString dataFilename);
    void setEAConstruction(EAConstruction* eaConstruction);
    void setIsSaveJson(bool isSaveJson);
    void setWorkingDirectory(QString workingDirectory);
    void setEaSpeakers(EAItemList* eaSpeakers);
private:
    static void append_eaItemLists(QQmlListProperty<EAItemList> *list
                                   , EAItemList *itemList);
    static int count_eaItemLists(QQmlListProperty<EAItemList> *list);
    static EAItemList* at_eaItemLists(QQmlListProperty<EAItemList> *list
                                      , int index);
    static void clear_eaItemLists(QQmlListProperty<EAItemList> *list);
};

#endif // EVENTCONTAINER_H
























