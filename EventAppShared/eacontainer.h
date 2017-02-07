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
class HttpDownload;
//enum SaveFormat {Json, Binary }

static const QString ENCODE_FIREBASE_URL = "AwLFcODje2DJs+8HlZsBC7zBxnG8+iQvzvWiS5CSDAa91cBitrJwfMqu5w==";
static const QString ENCODE_MAPBOX_TOKEN = "";
static const QString EVENT ="event";
static const QString CONSTRUCTION ="construction";
static const QString SPEAKERS ="speakers";
//static const QString FIREBASE_URL = "https://eventapp-2d821.firebaseio.com/";
static const quint64 SIMPLE_KEY = Q_UINT64_C(0x09d96fec6bbdc766);
static const quint64 MAP_KEY =    Q_UINT64_C(0x37f072cd54fd0545);
static const int NoIcon	= 0;	//the message box does not have any icon.
static const int Question =	4;	//an icon indicating that the message is asking a question.
static const int Information = 1;	//an icon indicating that the message is nothing out of the ordinary.
static const int Warning = 2;	//an icon indicating that the message is a warning, but can be dealt with.
static const int Critical = 3;	//an icon indicating that the message represents a critical problem.

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
    Q_PROPERTY(bool isEventStatic READ isEventStatic WRITE setIsEventStatic NOTIFY isEventStaticChanged)

    Q_PROPERTY(int imageVersion READ imageVersion WRITE setImageVersion NOTIFY imageVersionChanged)

    EAInfo* m_eaInfo;
    QString m_dataFilename = "temp";
    EAConstruction* m_eaConstruction;
    bool m_isSaveJson = true;
    QString m_workingDirectory = QCoreApplication::applicationDirPath();    
    QList<EAItemList*> m_eaItemLists;
    EAUser* m_user = NULL;

public:
    enum EventSource { None = 0, FileUrl, FBDirect, FBIndirect };

    EAContainer();

    virtual void classBegin();
    virtual void componentComplete();
    //Q_INVOKABLE void insertEmptyItemList(int index, QString name, bool formated = true);
    Q_INVOKABLE void insertEmptyItemList(int index, QString name, int listType);
    Q_INVOKABLE void addIcon(int index, const QString& filenameUrl);
    Q_INVOKABLE void deleteItemList(int index);
    Q_INVOKABLE int moveItemList(int index, bool directionUp);
    Q_INVOKABLE void clearEvent();
    Q_INVOKABLE QString listDisplayFormats();

    Q_INVOKABLE void downloadFromUrl(const QString& urlString);
    Q_INVOKABLE  bool loadNewEventApp(const QString& filenameUrl = "NewEvent");
    Q_INVOKABLE  bool loadEventApp();
    Q_INVOKABLE  bool saveEventApp(const QString &filenameUrl = "");
    Q_INVOKABLE void uploadApp(const QString& eventKey);

    Q_INVOKABLE void downloadApp(const QString& eventKey);
    Q_INVOKABLE void downloadApp(const QString& eventKey, const QString &fbUrl);
    Q_INVOKABLE void downloadAppEncoded(const QString& eventKey
                                 , const QString& encryptedUrl = ENCODE_FIREBASE_URL);
    Q_INVOKABLE void loadAnswers();
    Q_INVOKABLE  bool loadDisplayFormat(const QString &filenameUrl);
    Q_INVOKABLE  bool loadDisplayResource(const QString &filenameUrl);
    Q_INVOKABLE  bool saveDisplayFormat(const QString &filenameUrl);
    Q_INVOKABLE bool linkFirebaseUrl(QString eventKey
                                     , QDate to
                                     , QDate from = QDate::currentDate());
    Q_INVOKABLE QString getDebugLog() const;

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
    void saveAnswers(int itemListIndex
                     , int itemIndex
                     , QList<EaQuestion*> questionList);

    void dowloadFirbaseUrl();
    QString answers() const;

    bool isEventStatic() const;
    EventSource getEventSource() const;
    void setEventSource(const EventSource &eventSource);
    QList<EAItemList *> getEaItemLists() const;
    void setEaItemLists(const QList<EAItemList *> &eaItemLists);    
    int screenWidth() const;
    int screenHeight() const;
    void resetImageProviders();
    qreal point2PixelH() const;    
    int imageVersion() const;

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
    void error(const QString& message
            , const QString& information
            , const QString& details
            , int icon);
            //, int icon);
    void isEventStaticChanged(bool isEventStatic);
    void displayParasChanged();    
    void screenWidthChanged(int screenWidth);
    void screenHeightChanged(int screenHeight);
    void eventCleared();
    void point2PixelHChanged(qreal point2PixelH);    
    void imageVersionChanged(int imageVersion);

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
    void onFindFBUrlRequestReady(QByteArray);
    void onAnswersReady(QByteArray data);
    void onDataChanged(QString);    
    void setAnswers(QString answers);
    //void onFileDownloaded(QByteArray data);
    void onFileDownloadError(QString);
    void httpDownloadFinished();
    void setIsEventStatic(bool isEventStatic);
    void setImageVersion(int imageVersion);

private:
    QJsonObject jsonAnswers(EAItemList* eaItemList
                            , EAItem *item
                            , QList<EaQuestion*> questionList);
    void setAnswers(QJsonObject jsonAnswers);
    QJsonObject getServiceAccountKey(const QString& filename);
    void padOutIconst();
    static void append_eaItemLists(QQmlListProperty<EAItemList> *list
                                   , EAItemList *itemList);
    static int count_eaItemLists(QQmlListProperty<EAItemList> *list);
    static EAItemList* at_eaItemLists(QQmlListProperty<EAItemList> *list
                                      , int index);
    static void clear_eaItemLists(QQmlListProperty<EAItemList> *list);
    static QString getBaseFirebaseUrl();

    int m_Version = 0;
    int nextItemListId = 0;
    int useNextItemListId();
    QJsonArray jsonIcons;

    QString m_firbaseUrl = "";
    QString m_eventKey = "";
    QString m_answers;
    QJsonObject answersObj;

    HttpDownload* httpDownload;
    QString debugLog;
    bool m_isEventStatic = true;
    EventSource m_eventSource = None;
    bool indiretDownload = false;    
    int m_imageVersion = 0;
};

#endif // EVENTCONTAINER_H
























