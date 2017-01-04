#ifndef EVENTCONTAINER_H
#define EVENTCONTAINER_H
#include <QString>
#include <QQuickItem>
#include <QCoreApplication>
#include <QQmlEngine>
#include <QQmlListProperty>
#include <QtQml>
#include <QDate>

#include "eventappshared_global.h"

class EAInfo;
class EAConstruction;
class EAItemList;
class EAUser;
class EaQuestion;
class EAItem;
//enum SaveFormat {Json, Binary }

static const QString ENCODE_FIREBASE_URL = "AwLFcODje2DJs+8HlZsBC7zBxnG8+iQvzvWiS5CSDAa91cBitrJwfMqu5w==";
static const QString EVENT ="event";
static const QString CONSTRUCTION ="construction";
static const QString SPEAKERS ="speakers";
static const QString FIREBASE_URL = "https://eventapp-2d821.firebaseio.com/";
static const quint64 SIMPLE_KEY = Q_UINT64_C(0x09d96fec6bbdc766);

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
    Q_PROPERTY(EAUser* user READ user WRITE setUser NOTIFY userChanged)
    Q_PROPERTY(QString eventKey READ eventKey WRITE setEventKey NOTIFY eventKeyChanged)

    Q_PROPERTY(QString firbaseUrl READ firbaseUrl WRITE setFirbaseUrl NOTIFY firbaseUrlChanged)
    Q_PROPERTY(QString answers READ answers WRITE setAnswers NOTIFY answersChanged)

    EAInfo* m_eaInfo;
    QString m_dataFilename = "temp";
    EAConstruction* m_eaConstruction;
    bool m_isSaveJson = true;
    QString m_workingDirectory = QCoreApplication::applicationDirPath();    
    QList<EAItemList*> m_eaItemLists;
    EAUser* m_user = NULL;

public:
    EAContainer();

    virtual void classBegin();
    virtual void componentComplete();
    Q_INVOKABLE void insertEmptyItemList(int index, QString name, bool formated = true);
    Q_INVOKABLE void deleteItemList(int index);
    Q_INVOKABLE void clearEvent();

    Q_INVOKABLE  bool loadNewEventApp(const QString& filename = "NewEvent");
    Q_INVOKABLE  bool loadEventApp();
    Q_INVOKABLE  bool saveEventApp(const QString &filename = "");
    Q_INVOKABLE void uploadApp(const QString& eventKey);

    Q_INVOKABLE void downloadApp(const QString& eventKey);
    Q_INVOKABLE void downloadApp(const QString& eventKey, const QString &fbUrl);
    Q_INVOKABLE void downloadAppEncoded(const QString& eventKey
                                 , const QString& encryptedUrl = ENCODE_FIREBASE_URL);
    Q_INVOKABLE void loadAnswers();
    Q_INVOKABLE  bool loadDisplayFormat(const QString &filename);
    Q_INVOKABLE  bool saveDisplayFormat(const QString &filename);
    Q_INVOKABLE bool linkFirebaseUrl(QString eventKey
                                     , QDate to
                                     , QDate from = QDate::currentDate());

    void  eventAppToSettings(QJsonDocument eventDoc);
    QJsonDocument  eventAppFromSettings();

    void read(const QJsonObject &json);
    void write(QJsonObject &json);
    QString workingDirectory() const;

    EAInfo* eaInfo() const;
    QString dataFilename() const;
    EAConstruction* eaConstruction() const;
    bool isSaveJson() const;    
    QQmlListProperty<EAItemList> eaItemLists();
    int version() const;
    QString firbaseUrl() const;    
    EAUser *user();
    QString eventKey() const;
    void saveAnswers(EAItemList* eaItemList
                     , EAItem* item
                     , QList<EaQuestion*> questionList);

    QString answers() const;

    Q_INVOKABLE QString getDebugLog() const;

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
    void firbaseUrlChanged(QString firbaseUrl);
    void userChanged(EAUser* user);
    void eventKeyChanged(QString eventKey);    
    void answersChanged(QString answers);
    void eaAnswersDownloaded();

public slots:
    void setEAInfo(EAInfo* eaInfo);
    void setDataFilename(const QString &dataFilename);
    void setEAConstruction(EAConstruction* eaConstruction);
    void setIsSaveJson(bool isSaveJson);
    void setWorkingDirectory(QString workingDirectory);
    void setVersion(int version);
    void setFirbaseUrl(QString firbaseUrl);
    void setUser(EAUser *user);
    void setEventKey(QString eventKey);
    void onResponseReady(QByteArray);
    void onAnswersReady(QByteArray data);
    void onDataChanged(QString);    
    void setAnswers(QString answers);

private:
    QJsonObject jsonAnswers(EAItemList* eaItemList
                            , EAItem *item
                            , QList<EaQuestion*> questionList);
    void setAnswers(QJsonObject jsonAnswers);
    QJsonObject getServiceAccountKey(const QString& filename);

    static void append_eaItemLists(QQmlListProperty<EAItemList> *list
                                   , EAItemList *itemList);
    static int count_eaItemLists(QQmlListProperty<EAItemList> *list);
    static EAItemList* at_eaItemLists(QQmlListProperty<EAItemList> *list
                                      , int index);
    static void clear_eaItemLists(QQmlListProperty<EAItemList> *list);

    int m_Version = 0;
    int nextItemListId = 0;
    int useNextItemListId();

    QString m_firbaseUrl = FIREBASE_URL;
    QString m_eventKey = "";
    QString m_answers;
    QJsonObject answersObj;

    QString debugLog;
};

#endif // EVENTCONTAINER_H
























