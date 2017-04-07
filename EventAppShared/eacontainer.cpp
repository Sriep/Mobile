#include <QJsonDocument>
#include <QJsonArray>
#include <QIODevice>
#include <QJsonObject>
#include <QJsonValue>
#include <QFileInfo>
#include <QDir>
#include <QCryptographicHash>
#include <QDebug>
#include <QQmlEngine>
#include <QtQml>
#include <QClipboard>
#include <QGuiApplication>

//#include <QApplication>
//#include <QScreen>
#include <cstdlib>
#include <QProcess>

#include "picturelistimageprovider.h"
#include "firebase.h"
#include "eacontainer.h"
#include "eainfo.h"
#include "eaconstruction.h"
#include "eaitemlist.h"
#include "eauser.h"
#include "eaitem.h"
#include "eaquestion.h"
#include "simplecrypt.h"
#include "httpdownload.h"
#include "assistant.h"

QList<EAItemList *> EAContainer::getEaItemLists() const
{
    return m_eaItemLists;
}

void EAContainer::setEaItemLists(const QList<EAItemList *> &eaItemLists)
{
    m_eaItemLists = eaItemLists;
}

void EAContainer::resetImageProviders()
{
    setImageVersion(imageVersion() + 1);

    for ( int i=0 ; i < m_eaItemLists.length() ; i++ )
    {
        m_eaItemLists[i]->resetImageProvider(this);
    }

    padOutIconst();
    QQmlEngine* engine = qmlEngine(this);
    if (engine)
    {
        QString oldId = "listIcons_" + QString::number(imageVersion()-1);
        QQmlImageProviderBase* provider = engine->imageProvider(oldId);
        if (provider)
            engine->removeImageProvider(oldId);
        PictureListImageProvider* newProvider;

        QJsonValue eventIcon = getEventIcon();
        if (!showEventIcon())
        {
            QPixmap nullPix;
            eventIcon = jsonValFromPixmap(nullPix);
        }
        newProvider = new PictureListImageProvider(jsonIcons, eventIcon);
        QString newId = "listIcons_" + QString::number(imageVersion());
        qDebug() << "resetImageProvider: number icons: " << jsonIcons.size() << " id: " << newId;
        engine->addImageProvider(newId, newProvider);
    }
}

int EAContainer::imageVersion() const
{
    return m_imageVersion;
}

void EAContainer::padOutIconst()
{
    QPixmap nullPix;
    QJsonValue nullJson = jsonValFromPixmap(nullPix);

    int numItems = m_eaItemLists.size();
    for ( int i = jsonIcons.size() ; i<numItems ; i++ )
    {
        jsonIcons.append(nullJson);
    }
}

void EAContainer::addIcon(int index,  const QString& filenameUrl)
{
    QString filename = QUrl(filenameUrl).toLocalFile();
    QImage picImage(filename);
    //picImage = picImage.scaled(50,50, Qt::KeepAspectRatio);
    QPixmap pix = QPixmap::fromImage(picImage);
    QJsonValue jsonPic = jsonValFromPixmap(pix);

    padOutIconst();
    if (0 <= index)
        jsonIcons[index] = jsonPic;
    else
        setEventIcon(jsonPic);
    resetImageProviders();
    refreshData();
}

void EAContainer::clearIcon(int index)
{
    padOutIconst();
    if (0 <= index)
        jsonIcons[index] = QJsonValue();
    else
        setEventIcon(QJsonValue());
    resetImageProviders();
    refreshData();
}

void EAContainer::addEventIcon(const QString &filenameUrl, int height)
{
    QString filename = QUrl(filenameUrl).toLocalFile();
    QImage picImage(filename);
    picImage = picImage.scaled(height,height, Qt::KeepAspectRatio);
    QPixmap pix = QPixmap::fromImage(picImage);
    QJsonValue jsonPic = jsonValFromPixmap(pix);
    setShowEventIcon(true);

    padOutIconst();
    setEventIcon(jsonPic);
    resetImageProviders();
    refreshData();
}

void EAContainer::clearEventIcon()
{
    setShowEventIcon(false);

    padOutIconst();

    //QPixmap nullPix;
    //QJsonValue jsonPic = jsonValFromPixmap(nullPix);
    //setEventIcon(jsonPic);
    setEventIcon(QJsonValue());

    resetImageProviders();
    refreshData();
}

EAContainer::EAContainer()
{
    m_eaConstruction = new EAConstruction;
    m_eaInfo = new EAInfo;
    assistant = new Assistant;
}

void EAContainer::classBegin()
{
    // Perform some initialization here now that the object is fully created
}

void EAContainer::componentComplete()
{
    // Perform some initialization here now that the object is fully created
    //loadEventApp();
    //emit eaComponentComplete();
}

//void EAContainer::insertEmptyItemList(int index, QString name, bool formated)
void EAContainer::insertEmptyItemList(int index, QString name, int listType)
{
    EAItemList* newItemList = new EAItemList(name);
    //newItemList->setFormatedList(formated);
    newItemList->setListType(listType);
    newItemList->setEaContainer(this);
    m_eaItemLists.insert(index, newItemList);

    QPixmap nullPix;
    QJsonValue nullJson = jsonValFromPixmap(nullPix);
    jsonIcons.insert(index, nullJson);
    resetImageProviders();
    emit eaItemListsChanged();
}

void EAContainer::deleteItemList(int index)
{
    if (index >= 0 && index < m_eaItemLists.count())
    {
        m_eaItemLists.removeAt(index);
        resetImageProviders();
        emit eaItemListsChanged();
    }
}

int EAContainer::moveItemList(int index, bool directionUp)
{
    if (index < m_eaItemLists.count() && index >= 0)
    {
        if (directionUp)
        {
            if (0 == index)
            {
                emit error(tr("Error moving item list")
                            ,tr("Item already at top of list")
                            ,"EAContainer::moveItemList"
                            , Warning);
                return index;
            }
            /*else
            {
                m_eaItemLists.swap(index, index -1);
                QJsonValue temp = jsonIcons[index];
                jsonIcons[index] = jsonIcons[index-1];
                jsonIcons[index-1] = temp;
                resetImageProviders();
                emit eaItemListsChanged();
                return index-1;
            }*/
        }
        else
        {
            if (m_eaItemLists.count()-1 == index)
            {
                emit error(tr("Error moving itme list")
                            ,tr("Item already at bottom of list")
                            ,"EAContainer::moveItemList"
                            , Warning);
                return index;
            }
            /*else
            {

                m_eaItemLists.swap(index, index +1);
                QJsonValue temp = jsonIcons[index];
                jsonIcons[index] = jsonIcons[index+1];
                jsonIcons[index+1] = temp;
                resetImageProviders();
                emit eaItemListsChanged();
                return index +1;
            }*/
        }
        int delta = directionUp ? -1 : +1;
        m_eaItemLists.swap(index, index + delta);
        QJsonValue temp = jsonIcons[index];
        jsonIcons[index] = jsonIcons[index+delta];
        jsonIcons[index+delta] = temp;
        resetImageProviders();
        emit eaItemListsChanged();
        return index + delta;


    }
    else
    {
        emit error(tr("Error moving item list")
                    ,tr("Invalid index ") + QString::number(index)
                    ,"EAContainer::moveItemList"
                    , Warning);
        return -1;
    }
}

EAInfo *EAContainer::eaInfo() const
{
    return m_eaInfo;
}

QString EAContainer::dataFilename() const
{
    return m_dataFilename;
}


bool EAContainer::loadNewEventApp(const QString &filenameUrl)
{
    QString filename = QUrl(filenameUrl).toLocalFile();
    if (filename.size() == 0)
        return false;

    clearEvent();
    setDataFilename(filename);

    QFile loadFile(filename);
    if (!loadFile.open(QIODevice::ReadOnly)) {
        emit error("Error loading event from file"
                    ,"Cannot open file " + filename
                    ,"EAContainer::loadNewEventApp\nloadFile.open==false"
                    , Warning);
        return false;
    }

    QByteArray saveData = loadFile.readAll();

    QJsonDocument loadDoc(isSaveJson()
        ? QJsonDocument::fromJson(saveData)
        : QJsonDocument::fromBinaryData(saveData));
    QJsonObject jsonObj(loadDoc.object());
    read(jsonObj);
    setIsEventStatic(true);
    setEventSource(FileUrl);
    eventAppToSettings(loadDoc);

    emit eaItemListsChanged();
    //emit displayParasChanged();
    return true;
}

bool EAContainer::loadEventApp()
{
    QSettings settings;
    if (settings.contains("data/eventData"))
    {
        QJsonDocument eventDoc(eventAppFromSettings());
        read(eventDoc.object());

    }
    else if (dataFilename().size() > 0)
    {
        loadNewEventApp(dataFilename());
    }
    qDebug() << "EAContainer::loadEventApp finished";
    emit eaItemListsChanged();
    emit eaConstructionChanged(m_eaConstruction);
    //emit displayParasChanged();
    return true;
}

bool EAContainer::saveEventApp(const QString& filenameUrl)
{
    QString filename = QUrl(filenameUrl).toLocalFile();

    qDebug() << "saveEventApp filename: " << filename;
    if (filename != "")
        setDataFilename(filename);

    QFile saveFile(filename);
    if (!saveFile.open(QIODevice::WriteOnly)) {
        emit error(tr("Error saving event to file")
                    ,tr("Cannot open file ") + filename
                    ,"EAContainer::saveEventApp\nsaveFile.open==false"
                    , Critical);
        return false;
    }

    QJsonObject containerObject;
    write(containerObject);
    QJsonDocument saveDoc(containerObject);
    saveFile.write(isSaveJson()
        ? saveDoc.toJson()
        : saveDoc.toBinaryData());

    eventAppToSettings(saveDoc);
    return true;
}

bool EAContainer::saveDisplayFormat(const QString &filenameUrl)
{
    QString filename = QUrl(filenameUrl).toLocalFile();
    qDebug() << "saveDisplayFormat filename: " << filename;

    QFile saveFile(filename);
    //QFile saveFile(filename);
    if (!saveFile.open(QIODevice::WriteOnly)) {
        emit error(tr("Error saving dispaly parameters to file")
                    ,tr("Cannot open file ") + filename
                    ,"EAContainer::saveDisplayFormat\nsaveFile.open==false"
                    , Critical);
        return false;
    }
    QJsonObject djisplayObject;
    eaConstruction()->write(djisplayObject);
    QJsonDocument saveDoc(djisplayObject);
    saveFile.write(saveDoc.toJson());
    return true;
}

bool EAContainer::linkFirebaseUrl(QString eventKey, QDate to, QDate from)
{
    SimpleCrypt crypto(SIMPLE_KEY);
    QString encFbUrl = crypto.encryptToString(firbaseUrl());
    QString baseFbUrl = crypto.decryptToString(ENCODE_FIREBASE_URL);

    QJsonObject linkData;
    linkData["link"] = true;
    linkData["url"] = encFbUrl;
    linkData["from"] = from.toJulianDay();
    linkData["to"] = to.toJulianDay();
    QJsonObject linkObj { {eventKey,  linkData} };
    QJsonDocument uploadDoc(linkObj);

    Firebase *firebase=new Firebase(baseFbUrl);
    firebase->setValue(uploadDoc, "PATCH");
    return true;
}

void EAContainer::eventAppToSettings(QJsonDocument eventDoc)
{
    QSettings settings;
    QByteArray ba;
    if (m_isSaveJson)
        ba = eventDoc.toJson(QJsonDocument::Compact);
    else
        ba = eventDoc.toBinaryData();
    settings.setValue("data/eventData", QVariant(ba));
}

QJsonDocument EAContainer::eventAppFromSettings()
{
    QSettings settings;
    QByteArray ba(settings.value("data/eventData").toByteArray());

    if (m_isSaveJson)
        return QJsonDocument::fromJson(ba);
    else
        return QJsonDocument::fromBinaryData(ba);
}

void EAContainer::uploadApp(const QString &eventKey)
{
    setEventKey(eventKey);
    QJsonObject dataObject;
    setIsEventStatic(false);
    write(dataObject);
    QJsonValue dataValue(dataObject);
    QJsonObject containerObj {{eventKey,  dataValue} };
    QJsonDocument uploadDoc(containerObj);

    Firebase *firebase=new Firebase(firbaseUrl());
    firebase->setValue(uploadDoc, "PATCH");

    eventAppToSettings(uploadDoc);
}

void EAContainer::downloadApp(const QString &eventKey)
{
    downloadApp(eventKey, firbaseUrl());
}

QString EAContainer::getBaseFirebaseUrl()
{
    SimpleCrypt crypto(SIMPLE_KEY);
    return crypto.decryptToString(ENCODE_FIREBASE_URL);
}
void EAContainer::downloadApp(const QString &eventKey, const QString& fbUrl)
{
    clearEvent();
    setEventKey(eventKey);
    Firebase *firebase=new Firebase(fbUrl, eventKey);

    //QString serviceEmail = "eventapp-2d821@appspot.gserviceaccount.com";
    //QJsonObject keyObj = getServiceAccountKey("PrivateKey.json");
    //QString key =  keyObj["private_key"].toString();
    //QString token = firebase->getToken(serviceEmail, key.toUtf8());

    //QScreen *screen = QApplication::screens().at(0);
    //int width =screen->availableGeometry().width();
    //int height  =screen->availableGeometry().height();
    //qDebug() << "screen width: " << width << " screen height: " << height;

    debugLog += "\nAbout to download event";
    debugLog += "\nEvent Key: " + eventKey;
    debugLog += "\nFirebase url: " + firbaseUrl();
    debugLog += "\nFirebase url: " + firebase->getPath().url();
    indiretDownload = false;
    firebase->getValue();
    connect(firebase,SIGNAL(eventResponseReady(QByteArray)),
            this,SLOT(onResponseReady(QByteArray)));
    connect(firebase,SIGNAL(eventDataChanged(QString)),
            this,SLOT(onDataChanged(QString*)));
}

void EAContainer::downloadAppEncoded(const QString &eventKey
                                     , const QString& encryptedUrl)
{
    SimpleCrypt crypto(SIMPLE_KEY);
    QString fbUrl = crypto.decryptToString(encryptedUrl);
    setFirbaseUrl(fbUrl);
    downloadApp(eventKey, fbUrl);
}

void EAContainer::httpDownloadFinished()
{
    QByteArray data = httpDownload->downloadData();
    httpDownload = NULL;
    onResponseReady(data);
}

QString EAContainer::copyFromClipboard()
{
    QClipboard *clipboard = QGuiApplication::clipboard();
    //QString originalText = clipboard->text();
    //QClipboard clipboard;
    qDebug() << clipboard->text();
    return clipboard->text();
}

void EAContainer::refreshData()
{
    QJsonObject containerObject;
    write(containerObject);
    QJsonDocument saveDoc(containerObject);
    eventAppToSettings(saveDoc);

    clearEvent();

    read(saveDoc.object());
    emit eaItemListsChanged();
}

QString EAContainer::appVersion()
{ 
    QProcess* process = new QProcess(this);;
    QStringList args;
    args << "describe" << "--always" << "--tags";
    process->start(GIT_EXE, args);
    process->waitForFinished(-1);
    return QString(process->readAllStandardOutput());
}

void EAContainer::setIsEventStatic(bool isEventStatic)
{
    if (m_isEventStatic == isEventStatic)
        return;

    m_isEventStatic = isEventStatic;
    emit isEventStaticChanged(isEventStatic);
}

void EAContainer::setImageVersion(int imageVersion)
{
    if (m_imageVersion == imageVersion)
        return;

    m_imageVersion = imageVersion;
    emit imageVersionChanged(imageVersion);
}

void EAContainer::setShowEventIcon(bool showEventIcon)
{
    if (m_showEventIcon == showEventIcon)
        return;

    m_showEventIcon = showEventIcon;
    emit showEventIconChanged(showEventIcon);
}

void EAContainer::onResponseReady(QByteArray data)
{
    qDebug()<<"answer";
    //qDebug()<<data;
    if (data.size() == 0)
    {
        emit error(tr("Error downloading app")
                   ,tr("Cannot access database")
                   ,"EAContainer::onResponseReady\ndata.size()==0"
                   , Critical);
        return;
    }
    else if (data == "null")
    {
        emit error(tr("Error downloading app")
                   , tr("Key not recognised")
                   , "EAContainer::onResponseReady\ndata==null"
                   , Critical);
        return;
    }
    QString strData(data);
    debugLog += "\nData returned: " + strData.left(100);

    QJsonDocument loadDoc = QJsonDocument::fromJson(data);
    QJsonObject topObj = loadDoc.object();
    //QJsonObject mainData = topObj.begin().value().toObject();
    //read(mainData);
    if (topObj["link"].toBool())
    {
        //qint64 julFrom = topObj["from"].toInt();
        //qint64 julTo = topObj["to"].toInt();
        //QDate fromDate = QDate::fromJulianDay(julFrom);
        //QDate toDate = QDate::fromJulianDay(julTo);
        //QDate today = QDate::currentDate();
        if (true)//(fromDate <= today && today <= toDate)
        {
            indiretDownload = true;
            QString encodedFbUrl = topObj["url"].toString();
            downloadAppEncoded(eventKey(), encodedFbUrl);
        }
        else
        {
            emit error(tr("Error downloading app")
                        ,tr("Invalid date")
                        ,tr("fromDate > today || today > toDate")
                        , Critical);
        }
    }
    else
    {
        read(topObj);
        setIsEventStatic(false);
        setEventSource(indiretDownload ? FBIndirect : FBDirect);
        eventAppToSettings(loadDoc);
        qDebug() << "EAContainer::downloadEventApp finished";
        emit eaItemListsChanged();
        emit eaConstructionChanged(eaConstruction());
        //emit displayParasChanged();
    }
}

void EAContainer::dowloadFirbaseUrl()
{
    if (eventKey().size() > 0 && firbaseUrl().size() == 0)
    {
        Firebase *firebase = new Firebase(getBaseFirebaseUrl(), eventKey());
        firebase->getValue();
        connect(firebase,SIGNAL(eventResponseReady(QByteArray)),
                this,SLOT(onFindFBUrlRequestReady(QByteArray)));
    }
}

void EAContainer::onFindFBUrlRequestReady(QByteArray data)
{
    if (data.size() == 0 || data == "null")
    {
        emit error(tr("Error downloading data")
                   ,tr("Cannot find database")
                   ,"EAContainer::onResponseReady\ndata.size()==0"
                   , Critical);
        return;
    }
    QString strData(data);
    QJsonDocument loadDoc = QJsonDocument::fromJson(data);
    QJsonObject topObj = loadDoc.object();
    //QJsonObject mainData = topObj.begin().value().toObject();
    //read(mainData);
    if (topObj["link"].toBool())
    {
        QString encodedFbUrl = topObj["url"].toString();
        SimpleCrypt crypto(SIMPLE_KEY);
        QString fbUrl = crypto.decryptToString(encodedFbUrl);
        setFirbaseUrl(fbUrl);
    }
    else
    {
        setFirbaseUrl(getBaseFirebaseUrl());
    }
}

void EAContainer::onDataChanged(QString data)
{
    qDebug()<<data;
}

void EAContainer::setAnswers(QString answers)
{
    if (m_answers == answers)
        return;

    m_answers = answers;
    emit answersChanged(answers);
}
/*
void EAContainer::onFileDownloaded(QByteArray data)
{
   // onResponseReady
}
*/
void EAContainer::onFileDownloadError(QString errorMessage)
{
    emit error("Error downloading file from url"
                , errorMessage
                ,"EAContainer::onFileDownloadError slotted from HttpDownload"
               , Critical);
}



void EAContainer::setAnswers(QJsonObject jsonAnswers)
{
    QJsonDocument anwserDoc(jsonAnswers);
    answersObj = jsonAnswers;
    setAnswers(QString(anwserDoc.toJson()));
}

QJsonObject EAContainer::getServiceAccountKey(const QString &filename)
{
    QFile loadFile(filename);
    if (!loadFile.open(QIODevice::ReadOnly)) {
        qWarning("Couldn't open save file.");
        return QJsonObject();
    }
    QByteArray saveData = loadFile.readAll();
    QJsonDocument keyDoc(QJsonDocument::fromJson(saveData));
    return  keyDoc.object();

}

void EAContainer::setFirbaseUrl(QString firbaseUrl)
{
    QString trimmedFirebaseUrl = firbaseUrl.trimmed();
    if (m_firbaseUrl == trimmedFirebaseUrl)
        return;

    m_firbaseUrl = trimmedFirebaseUrl;
    emit firbaseUrlChanged(trimmedFirebaseUrl);
}

void EAContainer::setUser(EAUser* user)
{
    if (m_user == user)
        return;

    m_user = user;
    m_user->setEaContainer(this);
    emit userChanged(user);
}

void EAContainer::setEventKey(QString eventKey)
{
    QString eventKeyFirebaseUrl = eventKey.trimmed();
    if (m_eventKey == eventKeyFirebaseUrl)
        return;

    m_eventKey = eventKeyFirebaseUrl;
    emit eventKeyChanged(eventKeyFirebaseUrl);
}

void EAContainer::read(const QJsonObject &json)
{
    QJsonObject eventInfoObj = json["event"].toObject();
    m_eaInfo->read(eventInfoObj);

    nextItemListId = eventInfoObj["version"].toInt();
    setEventKey(eventInfoObj["eventKey"].toString());
    setIsEventStatic(eventInfoObj["isEv:loentStatic"].toBool());
    setEventSource((EventSource)eventInfoObj["eventSource"].toInt());
    setVersion(eventInfoObj["version"].toInt());
    setEventIcon(eventInfoObj["eventIcon"]);
    setShowEventIcon(eventInfoObj["showEventIcon"].toBool());
    emit eaInfoChanged(m_eaInfo);

    jsonIcons = json["icons"].toArray();    
    QJsonArray listsArray = json["itemLists"].toArray();
    for (int i = 0; i < listsArray.size(); ++i) {
        QJsonObject readJsonObject = listsArray[i].toObject();
        EAItemList* newList = new EAItemList();        

        m_eaItemLists.append(newList);
        newList->read(readJsonObject, this);
    }
    if (json.contains("construction"))
    {
        m_eaConstruction->read(json["construction"].toObject());
        emit eaConstructionChanged(m_eaConstruction);
    }
    resetImageProviders();
/*
    nextItemListId = json["version"].toInt();
    setEventKey(json["eventKey"].toString());
    setIsEventStatic(json["isEv:loentStatic"].toBool());
    setEventSource((EventSource)json["eventSource"].toInt());
    setVersion(json["version"].toInt());
*/
}

void EAContainer::clearEvent()
{
    m_eaInfo  = new EAInfo();
    m_user = new EAUser(this);
    m_dataFilename = "NewEvent";
    //clearEventIcon();
    //setEventIcon(QJsonValue());
    setShowEventIcon(false);
    setEventIcon(QJsonValue());
    m_eaConstruction = new EAConstruction();
    jsonIcons = QJsonArray();
    m_eaItemLists.clear();
    emit eventCleared();
    emit eaItemListsChanged();
}

QString EAContainer::listDisplayFormats()
{
    //QDirIterator it(":/content/displays/", QDirIterator:: Subdirectories);
    QString formats;
    //QDirIterator it(":/displays/", QDirIterator::NoIteratorFlags);
    QDirIterator it(":/shared/displays/", QDirIterator::NoIteratorFlags);
    //QDirIterator it("../EventApp/displays/", QDirIterator::NoIteratorFlags);
    while (it.hasNext()) {
        qDebug() << it.next();
        formats += it.fileName();
        qDebug() << it.fileName();
        //formats += " ";
    }
    return formats;
}

void EAContainer::downloadFromUrl(const QString &urlString)
{
    clearEvent();
    httpDownload = new HttpDownload;
    httpDownload->downloadFileData(urlString);

    connect(httpDownload,SIGNAL(downloadedData(QByteArray data)),
            this,SLOT(onResponseReady(QByteArray data)));

    connect(httpDownload,SIGNAL(downloadDataFinished()),
            this,SLOT(httpDownloadFinished()));

    connect(httpDownload,SIGNAL(error(QString)),
            this,SLOT(onFileDownloadError(QString)));
}

void EAContainer::write(QJsonObject &json)
{
    //json["dataFilename"] = m_dataFilename;

    QJsonObject eventInfoObject;
    m_eaInfo->write(eventInfoObject);
    eventInfoObject["eventKey"] = eventKey();
    eventInfoObject["nextItemListId"] = nextItemListId;
    eventInfoObject["isEventStatic"] = isEventStatic();
    eventInfoObject["version"] = ++m_Version;
    eventInfoObject["link"] = false;
    eventInfoObject["showEventIcon"] = showEventIcon();
    eventInfoObject["eventIcon"] = getEventIcon();
    json["event"] = eventInfoObject;

    json["icons"] = jsonIcons;
    QJsonObject constructionDataObject;
    m_eaConstruction->write(constructionDataObject);
    json["construction"] = constructionDataObject;

    QJsonArray listsArray;
    foreach (EAItemList* itemList, m_eaItemLists)
    {
        {
            QJsonObject itemListObject;
            itemList->write(itemListObject);
            listsArray.append(itemListObject);
        }
    }
    json["itemLists"] = listsArray;
}

EAConstruction *EAContainer::eaConstruction() const
{
    return m_eaConstruction;
}

bool EAContainer::isSaveJson() const
{
    return m_isSaveJson;
}

QString EAContainer::workingDirectory() const
{
    return m_workingDirectory;
}

void EAContainer::setEAInfo(EAInfo *eventInfo)
{
    if (m_eaInfo == eventInfo)
        return;

    m_eaInfo = eventInfo;
    emit eaInfoChanged(eventInfo);
}

void EAContainer::setDataFilename(const QString& dataFilename)
{
    if (m_dataFilename == dataFilename)
        return;

    m_dataFilename = dataFilename;
    QFileInfo info(m_dataFilename);

    QString filename = info.completeBaseName();
    QString path = info.path();
    QString extension = info.suffix();
    m_dataFilename = filename;
    setIsSaveJson(extension == "json" || extension == "");
    QDir::setCurrent(path);
    emit dataFilenameChanged(m_dataFilename);
}

void EAContainer::setEAConstruction(EAConstruction *eventAppConstruction)
{
    if (m_eaConstruction == eventAppConstruction)
        return;

    m_eaConstruction = eventAppConstruction;
    emit eaConstructionChanged(eventAppConstruction);
}

void EAContainer::setIsSaveJson(bool isSaveJson)
{
    if (m_isSaveJson == isSaveJson)
        return;

    m_isSaveJson = isSaveJson;
    emit isSaveJsonChanged(isSaveJson);
}

void EAContainer::setWorkingDirectory(QString workingDirectory)
{
    if (m_workingDirectory == workingDirectory)
        return;

    m_workingDirectory = workingDirectory;
    emit workingDirectoryChanged(workingDirectory);
}

void EAContainer::setVersion(int Version)
{
    if (m_Version == Version)
        return;

    m_Version = Version;
    emit versionChanged(Version);
}

QQmlListProperty<EAItemList> EAContainer::eaItemLists()
{
    return QQmlListProperty<EAItemList>(this
                                        , 0 // void *data
                                        , &EAContainer::append_eaItemLists
                                        , &EAContainer::count_eaItemLists
                                        , &EAContainer::at_eaItemLists
                                        , &EAContainer::clear_eaItemLists
                                        );
}

int EAContainer::version() const
{
    return m_Version;
}

QString EAContainer::firbaseUrl() const
{
    //if (m_firbaseUrl.size() == 0)
    //    dowloadFirbaseUrl();

    return m_firbaseUrl;
}

EAUser* EAContainer::user()
{
    if (!m_user)
        m_user = new EAUser(this);

    return m_user;
}

QString EAContainer::eventKey() const
{
    return m_eventKey;
}

//void EAContainer::saveAnswers(EAItemList* eaItemList
//                              , EAItem *item
//                              , QList<EaQuestion*> questionList)
void EAContainer::saveAnswers(int itemListIndex
                              , int itemIndex
                              , QList<EaQuestion*> questionList)
{
    if (eventKey() != "" && questionList.length() > 0 && !isEventStatic())
    {
        QString path = eventKey();
        path += "/answers";
        path += "/" + user()->user();
        path += "/" + QString::number(itemListIndex);
        path += "/" + QString::number(itemIndex);

        EAItemList* itemList = m_eaItemLists[itemListIndex];
        EAItem* item = itemList->getEaItems()[itemIndex];
        //QJsonArray answersArray = item->getAnsers();
        //QJsonDocument uploadDoc(answersArray);

        QJsonObject answersObj;
        answersObj["answers"] = item->getAnsers();
        QJsonDocument uploadDoc(answersObj);
        Firebase *firebase=new Firebase(firbaseUrl(), path);
        firebase->setValue(uploadDoc, "PATCH");
    }
}

void EAContainer::loadAnswers()
{
    if (eventKey() != "" && !isEventStatic())
    {
        QString path = eventKey();
        path += "/answers";
        Firebase *firebase=new Firebase(firbaseUrl(), path);
        firebase->getValue();
        connect(firebase,SIGNAL(eventResponseReady(QByteArray)),
                this,SLOT(onAnswersReady(QByteArray)));
        connect(firebase,SIGNAL(eventDataChanged(QString)),
                this,SLOT(onDataChanged(QString*)));
    }
}

bool EAContainer::loadDisplayFormat(const QString &filenameUrl)
{
    QString filename = QUrl(filenameUrl).toLocalFile();
    qDebug() << "loadDisplayFormat filename: " << filename;
    QFile loadFile(filename);
    if (!loadFile.open(QIODevice::ReadOnly)) {
        emit error(tr("Error loading dispaly parameters from file")
                    ,tr("Cannot open file ") + filename
                    ,"EAContainer::loadDisplayFormat\nloadFile.open==false"
                    , Critical);
        return false;
    }
    QByteArray saveData = loadFile.readAll();
    QJsonDocument loadDoc(QJsonDocument::fromJson(saveData));
    eaConstruction()->read(loadDoc.object());
    emit eaConstructionChanged(eaConstruction());
    return true;
}

bool EAContainer::loadDisplayResource(const QString &filename)
{
    //QString filename = QUrl(filenameUrl).toLocalFile();
    //qDebug() << "loadDisplayFormat filename: " << filename;
    QFile loadFile(filename);
    if (!loadFile.open(QIODevice::ReadOnly)) {
        emit error(tr("Error loading dispaly parameters from file")
                    ,tr("Cannot open file ") + filename
                    ,"EAContainer::loadDisplayFormat\nloadFile.open==false"
                    , Critical);
        return false;
    }
    QByteArray saveData = loadFile.readAll();
    QJsonDocument loadDoc(QJsonDocument::fromJson(saveData));
    eaConstruction()->read(loadDoc.object());
    emit eaConstructionChanged(eaConstruction());
    return true;
}


void EAContainer::onAnswersReady(QByteArray data)
{
    qDebug()<<"answer";
    QJsonDocument loadDoc = QJsonDocument::fromJson(data);
    answersObj = loadDoc.object();
    QByteArray ba = loadDoc.toJson(QJsonDocument::Indented);
    setAnswers(QString(ba));
    qDebug() << "EAContainer::onAnswersReady finished";
    emit eaAnswersDownloaded();
}

QString EAContainer::answers() const
{
    return m_answers;
}

QJsonObject EAContainer::jsonAnswers(EAItemList *eaItemList
                                     , EAItem *item
                                     , QList<EaQuestion *> questionList)
{
    QJsonArray answersArray;
    foreach (EaQuestion* answer, questionList)
    {
        {
            QJsonObject answerObj;
            answer->writeAnswer(answerObj);
            QJsonObject userAnswerObj {{ user()->user(), QJsonValue(answerObj)}};
            answersArray.append(userAnswerObj);
        }
    }
    QJsonObject itemAnswers{{item->title(), answersArray }};
    QJsonObject itemListAnswers{{ eaItemList->listName(), itemAnswers}};
    return itemAnswers;
}

//typedef QQmlListProperty::AppendFunction
//Synonym for void (*)(QQmlListProperty<T> *property, T *value).
//Append the value to the list property.
void EAContainer::append_eaItemLists(QQmlListProperty<EAItemList> *list
                                     , EAItemList *itemList)
{
    EAContainer *eaContainer = qobject_cast<EAContainer *>(list->object);
    if (itemList) {
        //itemList->setParentItem(eaContainer); //???
        //QQmlEngine*  engine = qmlEngine(eaContainer);
        itemList->setEaContainer(eaContainer);
        eaContainer->m_eaItemLists.append(itemList);
    }
}

//typedef QQmlListProperty::CountFunction
//Synonym for int (*)(QQmlListProperty<T> *property).
//Return the number of elements in the list property.
int EAContainer::count_eaItemLists(QQmlListProperty<EAItemList> *list)
{
    EAContainer *eaContainer = qobject_cast<EAContainer *>(list->object);
    return eaContainer->m_eaItemLists.count();
}

//typedef QQmlListProperty::AtFunction
//Synonym for T *(*)(QQmlListProperty<T> *property, int index).
//Return the element at position index in the list property.
EAItemList* EAContainer::at_eaItemLists(QQmlListProperty<EAItemList> *list
                                        , int index)
{
    EAContainer *eaContainer = qobject_cast<EAContainer *>(list->object);
    return eaContainer->m_eaItemLists[index];
}

//typedef QQmlListProperty::ClearFunction
//Synonym for void (*)(QQmlListProperty<T> *property).
//Clear the list property.
void EAContainer::clear_eaItemLists(QQmlListProperty<EAItemList> *list)
{
    EAContainer *eaContainer = qobject_cast<EAContainer *>(list->object);
    eaContainer->m_eaItemLists.clear();
}

int EAContainer::useNextItemListId()
{
    return nextItemListId++;
}

QJsonValue EAContainer::getEventIcon() const
{
    return eventIcon;
}

void EAContainer::setEventIcon(const QJsonValue &value)
{
    eventIcon = value;
}

bool EAContainer::showEventIcon() const
{
    return m_showEventIcon;
}

QJsonArray EAContainer::getJsonIcons() const
{
    return jsonIcons;
}

EAContainer::EventSource EAContainer::getEventSource() const
{
    return m_eventSource;
}

void EAContainer::setEventSource(const EventSource &eventSource)
{
    m_eventSource = eventSource;
}

QString EAContainer::getDebugLog() const
{
    return debugLog;
}

void EAContainer::startAssistant()
{
    assistant->showDocumentation("index.html");
}

bool EAContainer::isEventStatic() const
{
    return m_isEventStatic;
}
























