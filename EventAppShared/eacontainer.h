#ifndef EVENTCONTAINER_H
#define EVENTCONTAINER_H
#include <QString>
#include <QQuickItem>
#include <QCoreApplication>
#include <QQmlEngine>
#include <QQmlListProperty>
#include <QtQml>

#include "eventappshared_global.h"

class EAInfo;
class EAConstruction;
class EAItemList;
//enum SaveFormat {Json, Binary };

static const QString EVENT ="event";
static const QString CONSTRUCTION ="construction";
static const QString SPEAKERS ="speakers";
static const QString FIREBASE_URL = "https://eventapp-2d821.firebaseio.com/";

//class EVENTAPPSHAREDSHARED_EXPORT EAContainer : public QQuickItem
class  EAContainer : public QObject, public QQmlParserStatus
{
    Q_OBJECT
    Q_INTERFACES(QQmlParserStatus)
    Q_PROPERTY(EAInfo* eaInfo READ eaInfo WRITE setEAInfo NOTIFY eaInfoChanged)
    Q_PROPERTY(EAConstruction* eaConstruction READ eaConstruction WRITE setEAConstruction NOTIFY eaConstructionChanged)
    Q_PROPERTY(QQmlListProperty<EAItemList> eaItemLists READ eaItemLists)

    Q_PROPERTY(QString workingDirectory READ workingDirectory WRITE setWorkingDirectory NOTIFY workingDirectoryChanged)
    Q_PROPERTY(QString dataFilename READ dataFilename WRITE setDataFilename NOTIFY dataFilenameChanged)
    Q_PROPERTY(bool isSaveJson READ isSaveJson WRITE setIsSaveJson NOTIFY isSaveJsonChanged)
    Q_PROPERTY(int version READ version WRITE setVersion NOTIFY versionChanged)

    EAInfo* m_eaInfo;
    QString m_dataFilename;
    EAConstruction* m_eaConstruction;
    bool m_isSaveJson = true;
    QString m_workingDirectory = QCoreApplication::applicationDirPath();    
    QList<EAItemList*> m_eaItemLists;

public:
    EAContainer();

    virtual void classBegin();
    virtual void componentComplete();
    Q_INVOKABLE void insertEmptyItemList(int index, QString name);
    Q_INVOKABLE void deleteItemList(int index);
    Q_INVOKABLE void clearEvent();

    Q_INVOKABLE  bool loadNewEventApp(const QString& filename = "NewEvent");
    Q_INVOKABLE  bool loadEventApp();
    Q_INVOKABLE  bool saveEventApp(const QString &filename = "");
    Q_INVOKABLE void uploadApp(const QString& eventKey);
    Q_INVOKABLE void downloadApp(const QString& eventKey);


    void read(const QJsonObject &json);
    void write(QJsonObject &json);
    QString workingDirectory() const;

    EAInfo* eaInfo() const;
    QString dataFilename() const;
    EAConstruction* eaConstruction() const;
    bool isSaveJson() const;    
    QQmlListProperty<EAItemList> eaItemLists();
    int version() const;



signals:
    void eaInfoChanged(EAInfo* eaInfo);
    void dataFilenameChanged(QString dataFilename);
    void eaConstructionChanged(EAConstruction* eaConstruction);
    void isSaveJsonChanged(bool isSaveJson);
    void eaComponentComplete();
    void workingDirectoryChanged(QString workingDirectory);
    void loadedEventApp();
    void eaItemListsChanged();

    void versionChanged(int version);

public slots:
    void setEAInfo(EAInfo* eaInfo);
    void setDataFilename(const QString &dataFilename);
    void setEAConstruction(EAConstruction* eaConstruction);
    void setIsSaveJson(bool isSaveJson);
    void setWorkingDirectory(QString workingDirectory);
    void setVersion(int version);
    void onResponseReady(QByteArray);
    void onDataChanged(QString);

private:
    static void append_eaItemLists(QQmlListProperty<EAItemList> *list
                                   , EAItemList *itemList);
    static int count_eaItemLists(QQmlListProperty<EAItemList> *list);
    static EAItemList* at_eaItemLists(QQmlListProperty<EAItemList> *list
                                      , int index);
    static void clear_eaItemLists(QQmlListProperty<EAItemList> *list);

    int m_Version = 0;
    int nextItemListId = 0;
    int useNextItemListId();

};

#endif // EVENTCONTAINER_H
























