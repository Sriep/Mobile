#include <QJsonDocument>
#include <QJsonArray>
#include <QIODevice>
#include <QJsonObject>
#include <QJsonValue>
#include <QFileInfo>
#include <QDir>
#include <QDebug>
#include <QCryptographicHash>

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

QList<EAItemList *> EAContainer::getEaItemLists() const
{
    return m_eaItemLists;
}

void EAContainer::setEaItemLists(const QList<EAItemList *> &eaItemLists)
{
    m_eaItemLists = eaItemLists;
}

EAContainer::EAContainer()
{
    m_eaConstruction = new EAConstruction;
    m_eaInfo = new EAInfo;
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
    emit eaItemListsChanged();
}

void EAContainer::deleteItemList(int index)
{
    if (index < m_eaItemLists.count())
    {
        m_eaItemLists.removeAt(index);
        emit eaItemListsChanged();
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
        emit error("Error saving event to file"
                    ,"Cannot open file " + filename
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
        emit error("Error saving dispaly parameters to file"
                    ,"Cannot open file " + filename
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

void EAContainer::setIsEventStatic(bool isEventStatic)
{
    if (m_isEventStatic == isEventStatic)
        return;

    m_isEventStatic = isEventStatic;
    emit isEventStaticChanged(isEventStatic);
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
                        ,"fromDate > today || today > toDate"
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
    m_eaInfo->read(json["event"].toObject());
    emit eaInfoChanged(m_eaInfo);

    if (json.contains("construction"))
    {
        m_eaConstruction->read(json["construction"].toObject());
        emit eaConstructionChanged(m_eaConstruction);
    }

    QQmlEngine*  engine = qmlEngine(this);
    QJsonArray listsArray = json["itemLists"].toArray();
    for (int i = 0; i < listsArray.size(); ++i) {
        QJsonObject readJsonObject = listsArray[i].toObject();
        EAItemList* newList = new EAItemList();        
        //newList->read(readJsonObject, this);
        m_eaItemLists.append(newList);
        newList->read(readJsonObject, engine, this);
    }

    nextItemListId = json["version"].toInt();
    setEventKey(json["eventKey"].toString());
    setIsEventStatic(json["isEventStatic"].toBool());
    setEventSource((EventSource)json["eventSource"].toInt());
    setVersion(json["version"].toInt());

}

void EAContainer::clearEvent()
{
    m_eaInfo  = new EAInfo();
    m_user = new EAUser(this);
    m_dataFilename = "NewEvent";
    m_eaConstruction = new EAConstruction();
    m_eaItemLists.clear();

    emit eaItemListsChanged();
}

void EAContainer::downloadFromUrl(const QString &urlString)
{
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
    json["event"] = eventInfoObject;

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
    json["eventKey"] = eventKey();
    json["itemLists"] = listsArray;
    json["nextItemListId"] = nextItemListId;
    json["isEventStatic"] = isEventStatic();
    json["version"] = ++m_Version;
    json["link"] = false;
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
        path += "/" + QString::number(itemListIndex);
        path += "/" + QString::number(itemIndex);

        QJsonObject answersObj;
        EAItemList* itemList = m_eaItemLists[itemListIndex];
        EAItem* item = itemList->getEaItems()[itemIndex];
        item->writeAnswers(user(), answersObj);
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
        emit error("Error loading dispaly parameters from file"
                    ,"Cannot open file " + filename
                    ,"EAContainer::loadDisplayFormat\nloadFile.open==false"
                    , Critical);
        return false;
    }
    QByteArray saveData = loadFile.readAll();
    QJsonDocument loadDoc(QJsonDocument::fromJson(saveData));
    eaConstruction()->read(loadDoc.object());
    emit eaConstructionChanged(eaConstruction());
    //emit displayParasChanged();
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

bool EAContainer::isEventStatic() const
{
    return m_isEventStatic;
}
























