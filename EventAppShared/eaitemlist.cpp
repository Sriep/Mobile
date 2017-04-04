#include <QJsonObject>
#include <QJsonArray>
#include <QByteArray>
#include "QStringList"
#include <QtQml>
#include <csv.h>
#include <QDebug>
#include <QRegExp>
#include <QBuffer>
#include <QUrl>
#include <QDir>

#include <QQmlEngine>
#include <QtQml>

#include "eaitemlist.h"
#include "picturelistimageprovider.h"
#include "eamap.h"
#include "eauser.h"


EAItemList::EAItemList()
{

}
EAItemList::EAItemList(const QString &name)
    : m_listName(name) //EAItemListBase(name)
{
    init();
}

void EAItemList::init()
{
    setDataList(jsonData);

    QJsonObject dataObject;
    dataObject.insert("headerFields", QJsonValue(jsonFields));
    QJsonDocument jsonDoc(dataObject);
    QByteArray jsonBA = jsonDoc.toJson(QJsonDocument::Compact);
    setTitleFields(jsonBA);
}

EAItemList::~EAItemList()
{
}

void EAItemList::clear(EAContainer* eacontainer)
{
    //EAItemList::clear(eacontainer);
}


void EAItemList::resetImageProvider(EAContainer* eacontainer)
{
    padOutPictures();
    QQmlEngine* engine = qmlEngine(eacontainer);

    if (engine)
    {
        QString providerId = "list_" + QString::number(getIndex())  + "_";
        QString oldId = providerId + QString::number(eacontainer->imageVersion()-1);
        QQmlImageProviderBase* provider = engine->imageProvider(oldId);
        if (provider)
            engine->removeImageProvider(oldId);
        PictureListImageProvider* newProvider;
        newProvider = new PictureListImageProvider(jsonPictures);
        QString newId = providerId + QString::number(eacontainer->imageVersion());
        qDebug() << "resetImageProvider: number images: " << jsonPictures.size() << " id: " << newId;
        engine->addImageProvider(newId, newProvider);
    }
}

void EAItemList::read(const QJsonObject &json
//                      , QQmlEngine *engine
                      , EAContainer *eacontainer)
{
    setEaContainer(eacontainer);

    jsonFields = json["headerFields"].toArray();
    setTitleFields(jsonFields);
    emit titleFieldsChanged(titleFields());

    jsonData = json["dataList"].toArray();
    setDataList(jsonData);
    emit dataListChanged(dataList());

    setShortFormat(json["shortFormat"].toString());
    setLongFormat(json["longFormat"].toString());
    setFormatedList(json["formatedList"].toBool());
    setListType(json["listType"].toInt());
    nextItemId = json["nextItemId"].toInt();
    id = json["id"].toInt();
    version = json["version"].toInt();
    setListName(json["listName"].toString());
    setShowPhotos(json["showPhotos"].toBool());

    jsonPictures = json["pictures"].toArray();

    QJsonArray itemsArray = json["itemsList"].toArray();
    for (int i = 0; i < itemsArray.size(); ++i) {
        QJsonObject readJsonObject = itemsArray[i].toObject();
        EAItem* newitem = new EAItem();
        newitem->read(readJsonObject, this);
        m_eaItems.append(newitem);
    }

    //resetImageProvider(getEaContainer());
}

void EAItemList::write(QJsonObject &json)
{
    json["headerFields"] = jsonFields;
    json["dataList"] = jsonData;
    json["listName"] = listName();
    json["listType"] = listType();
    json["nextItemId"] = nextItemId;
    json["showPhotos"] = m_showPhotos;

    json["formatedList"] = formatedList();
    json["shortFormat"] = shortFormat();
    json["longFormat"] = longFormat();
    json["id"] = id;
    json["version"] = ++version;

    json["pictures"] = jsonPictures;
    QJsonArray itemsArray;
    foreach (EAItem* item, m_eaItems)
    {
        {
            QJsonObject itemObject;
            item->write(itemObject);
            itemsArray.append(itemObject);
        }

    }
    json["itemsList"] = itemsArray;
}

QString EAItemList::titleFields() const
{
    return m_titleFields;
}

QString EAItemList::dataList() const
{
    return m_dataList;
}

QString EAItemList::listName() const
{
    return m_listName;
}

bool EAItemList::showPhotos() const
{
    return m_showPhotos;
}

QString EAItemList::shortFormat() const
{
    return m_shortFormat;
}

QString EAItemList::longFormat() const
{
    return m_longFormat;
}

void EAItemList::setTitleFields(QString delegateList)
{
    if (m_titleFields == delegateList)
        return;    

    m_titleFields = delegateList;
    emit titleFieldsChanged(delegateList);
}

void EAItemList::setDataList(const QJsonArray &dataListArray)
{
    jsonData = dataListArray;
    QJsonObject dataObject;
    dataObject.insert("dataItems", QJsonValue(jsonData));
    QJsonDocument jsonDoc(dataObject);
    QByteArray jsonBA = jsonDoc.toJson(QJsonDocument::Compact);
    setDataList(QString(jsonBA));
}

void EAItemList::setListName(QString listName)
{
    if (m_listName == listName)
        return;

    m_listName = listName;
    emit listNameChanged(listName);
}

void EAItemList::setShowPhotos(bool showPhotos)
{
    if (m_showPhotos == showPhotos)
        return;

    m_showPhotos = showPhotos;
    emit showPhotosChanged(showPhotos);
}

void EAItemList::setShortFormat(QString shortFormat)
{
    if (m_shortFormat == shortFormat)
        return;

    m_shortFormat = shortFormat;
    emit shortFormatChanged(shortFormat);
}

void EAItemList::setLongFormat(QString longFormat)
{
    if (m_longFormat == longFormat)
        return;

    m_longFormat = longFormat;
    emit longFormatChanged(longFormat);
}

void EAItemList::setFormatedList(bool formatedList)
{
    if (m_formatedList == formatedList)
        return;

    m_formatedList = formatedList;
    emit formatedListChanged(formatedList);
}

void EAItemList::setListType(int listType)
{
    if (m_listType == listType)
        return;

    m_listType = listType;
    emit listTypeChanged(listType);
}

void EAItemList::setShowIcon(bool showIcon)
{
    if (m_showIcon == showIcon)
        return;

    m_showIcon = showIcon;
    emit showIconChanged(showIcon);
}


void EAItemList::setTitleFields(const QJsonArray &titleFields)
{
    jsonFields = titleFields;
    QJsonObject titleObject;
    titleObject.insert("headerFields", QJsonValue(jsonFields));
    QJsonDocument jsonDoc(titleObject);
    QByteArray jsonBA = jsonDoc.toJson(QJsonDocument::Compact);
    setTitleFields(QString(jsonBA));

    for ( int i=0 ; i < jsonFields.size() ; i++ )
    {
        QJsonObject jsonField = jsonFields[i].toObject();
        QString modelName = getModelName(jsonField["field"].toString());
        fieldsSet.insert(modelName);
    }
}

void EAItemList::setDataList(QString dataList)
{
    if (m_dataList == dataList)
        return;
    m_dataList = dataList;
    emit dataListChanged(dataList);
}

void EAItemList::loadCSV(const QString filenameUrl)
{
    QString filename = QUrl(filenameUrl).toLocalFile();

    QList<QStringList> csvListLines = CSV::parseFromFile(filename);
    if (csvListLines.length() > 0 )
    {
        QStringList headerList = csvListLines[0];
        //int listType = headerList[1].toInt();
        //int formatted = ListType::Formated;
        if (headerList[0] == "EventAppDrawer")
        {
            csvListLines.removeFirst();
            if (headerList[1].toInt() == (int) ListType::Formated)
                readMixedList(csvListLines);
            else
                readFormatedList(csvListLines);
        }
        else
            readFormatedList(csvListLines);

    }
    else
    {
        emit getEaContainer()->error(tr("Error loading csv file")
                    ,tr("No data found ")
                    ,"EAItemList::loadCSV csvListLines.length() <= 0"
                    , Warning);
    }
    getEaContainer()->resetImageProviders();
    emit eaItemListChanged();
}

void EAItemList::readFormatedList(QList<QStringList> csvListLines)
{
    QStringList headerList = csvListLines[0];
    csvListLines.removeFirst();

    QStringList headerModels = addHeaderFields(headerList);
    if (headerModels.length() == 0)
    {
        emit getEaContainer()->error(tr("Error loading csv file")
                    ,tr("No header fields found ")
                    ,"headerModels.length() == 0"
                    , Warning);
        return;
    }

    for ( int line=0 ; line < csvListLines.length() ; line++ )
    {
        QJsonObject newItem = newDataItem(csvListLines[line], headerModels);
        newItem["id"] = useNextItemId();
        jsonData.append(newItem);
    }
    setDataList(jsonData);
}

void EAItemList::readMixedList(QList<QStringList> listlist)
{
    for ( int line=0 ; line < listlist.length() ; line++ )
    {
        QString itemType = listlist[line][0];
        if ("Image" == itemType)
            readNewImageItem(listlist[line]);
        else if ("Text" == itemType)
            readNewTextItem(listlist[line]);
        else if ("Url" == itemType)
            readNewUrlItem(listlist[line]);
        else if ("Map" == itemType)
            readNewMapItem(listlist[line]);
        else if ("Question" == itemType)
            readNewQuestionItem(listlist[line]);
    }
}

void EAItemList::readNewImageItem(QStringList list)
{
    EAItem* newItem = new EAItem(EAItem::ItemType::Image, list[1]);
    newItem->setEaItemList(this);
    //getEaItems().append(newItem);
    m_eaItems.append(newItem);
    addPicture(getEaItems().length()-1, list[2]);
    getEaContainer()->resetImageProviders();
}

void EAItemList::readNewTextItem(QStringList list)
{
    QFile loadFile(list[2]);
    if (!loadFile.open(QIODevice::ReadOnly)) {
        emit getEaContainer()->error(tr("Error inserting text item")
                    ,tr("Can not load file ") + list[2]
                    ,"EAItemList::readNewTextItem"
                    , Warning);
        return;
    }
    QByteArray fileData = loadFile.readAll();
    QString fileText(fileData);
    EAItem* newItem = new EAItem(EAItem::ItemType::Document, list[1], fileText);
    newItem->setEaItemList(this);
    m_eaItems.append(newItem);
}

void EAItemList::readNewUrlItem(QStringList list)
{
    EAItem* newItem = new EAItem(list[1], QUrl(list[2]));
    newItem->setEaItemList(this);
    m_eaItems.append(newItem);
}

void EAItemList::readNewMapItem(QStringList list)
{
    EAItem* newItem = new EAItem(EAItem::ItemType::Map, list[1]);
    m_eaItems.append(newItem);
    EAMap* mapInfo = newItem->mapInfo();
    mapInfo->setMaptype(list[2]);
    mapInfo->setAccessToken(list[3]);
    mapInfo->setMapId(list[4]);
    mapInfo->setLatitude(list[5].toDouble());
    mapInfo->setLongitude(list[6].toDouble());
    mapInfo->setZoomLevel(list[7].toInt());
    mapInfo->setUseCurrent(list[8] == "true");
}

void EAItemList::readNewQuestionItem(QStringList list)
{
   // EAItem* newItem = new EAItem(EAItem::ItemType::Document);
   // newItem->setEaItemList(this);
    qDebug() << list[0];
   // getEaItems().append(newItem);
}

void EAItemList::saveCSV(const QString filenameUrl)
{
    QString filename = QUrl(filenameUrl).toLocalFile();

    QList<QStringList> dataStringLists;
    if (listType() == ListType::Formated)
        dataStringLists = formatted2StringLists(filename);
    else if (listType() == ListType::Manual)
        dataStringLists = manual2StringLists(filename);

    dataStringLists.prepend(headerList());
    CSV::write(dataStringLists, filename);
}

QList<QStringList> EAItemList::formatted2StringLists(const QString& imagePath)
{
    QJsonDocument tfDoc(QJsonDocument::fromJson(titleFields().toUtf8()));
    QJsonObject titleObject = tfDoc.object();
    QJsonDocument dlDoc(QJsonDocument::fromJson(dataList().toUtf8()));
    QJsonObject dataObject = dlDoc.object();
    QJsonArray headers = titleObject["headerFields"].toArray();
    QJsonArray data = dataObject["dataItems"].toArray();

    QList<QStringList> rtv;
    QStringList headerRow, headerNames;
    for ( int i=0 ; i<headers.size() ; i++ )
    {
        headerRow << headers[i].toObject()["field"].toString();
        headerNames << headers[i].toObject()["modelName"].toString();
    }
    if (showPhotos())
        headerRow << "picture";
    rtv << headerRow;

    for ( int j=0 ; j<data.size() ; j++ )
    {
        QJsonObject rowObject = data[j].toObject();
        QStringList row;
        for ( int i=0 ; i<headers.size() ; i++ )
        {
            QString cellData = rowObject[headerNames[i]].toString();
            row << cellData;
        }

        if (showPhotos())
        {
            row << savePicture(j, imagePath);
        }

        rtv << row;
    }

    return rtv;
}

QString EAItemList::savePicture(int index, const QString& path)
{
    QImage image = pixmapFrom(jsonPictures[index]).toImage();
    QString fname = saveItemFilename(index, path) + ".png";
    image.save(fname, "PNG");
    return fname;
}

QString EAItemList::saveItemFilename(int index, const QString &path)
{
    return path + "_" + QString::number(getIndex())
            + "_" + QString::number(index);
}

QStringList EAItemList::headerList()
{
    QStringList rtv;
    rtv << "EventAppDrawer";
    rtv << QString::number(listType());
    rtv << listName();
    return rtv;
}

QList<QStringList> EAItemList::manual2StringLists(const QString& imagePath)
{
    QList<QStringList> rtv;

    for ( int i=0 ; i<getEaItems().size() ; i++ )
    {
        QStringList row;

        EAItem* item = getEaItems()[i];
        switch (item->itemType()) {
        case EAItem::ItemType::Image:
            row << "Image";
            row << item->title();
            row << savePicture(i, imagePath);
            break;
        case EAItem::ItemType::Document:
            {
                row << "Text";
                row << item->title();
                QString fname = saveItemFilename(i, imagePath) + ".txt";
                QFile saveFile(fname);
                if (!saveFile.open(QIODevice::WriteOnly)) {
                    emit getEaContainer()->error(tr("Error saving item to file")
                                ,tr("Cannot save to file ") + fname
                                ,"EAItemList::manual2StringLists"
                                , Warning);
                }
                else
                    saveFile.write(item->displayText().toUtf8());
                row << fname;
            }
            break;
        case EAItem::ItemType::Url:
            row << "Url";
            row << item->title();
            row << item->urlString();
            break;
        case EAItem::ItemType::Map:
            row << "Map";
            row << item->title();
            row << item->mapInfo()->maptype();
            row << item->mapInfo()->accessToken();
            row << item->mapInfo()->mapId();
            row << QString::number(item->mapInfo()->latitude());
            row << QString::number(item->mapInfo()->longitude());
            row << QString::number(item->mapInfo()->zoomLevel());
            row << (item->mapInfo()->useCurrent() ? "true" : "false");
            break;
        case EAItem::ItemType::Questions:
            row << "Question";
            row << item->title();
        default:
            break;
        }
        rtv << row;
    }

    return rtv;
}

void EAItemList::amendField(int index
                            , const QString &field
                            , const QString &modelName
                            , const QString &format
                            , bool inListView)
{
    QJsonObject newField
    {
        { "field", field },
        { "modelName", modelName },
        { "format", format },
        { "inListView", inListView }
    };
    jsonFields[index] = QJsonValue(newField);
}

void EAItemList::saveTitleChanges()
{
    setTitleFields(jsonFields);
}

void EAItemList::loadPhotos(const QString &format)
{
    // http://stackoverflow.com/questions/14988455/count-qstring-arguments
    int argCount = format.count(QRegExp("%\\d{1,2}(?!\\d)"));
    qDebug() << "arg count " << argCount;
    QJsonObject obj0 = jsonFields[0].toObject();
    QString name0 = obj0["modelName"].toString();

    for ( int i=0 ; i<jsonData.count() ; i++ )
    {
        QJsonObject ithObj = jsonData[i].toObject();
        QString firstField = ithObj[name0].toString();
        QString filename = QString(format).arg(firstField);

        QImage  picImage(filename);
        picImage.scaled(100,100, Qt::AspectRatioMode::KeepAspectRatio);
        QPixmap pix = QPixmap::fromImage(picImage);
        QJsonValue jsonPic = jsonValFromPixmap(pix);
        if (jsonPictures.size() > i)
            jsonPictures[i] = jsonPic;
        else
            jsonPictures.append(jsonPic);
    }
    resetImageProvider(getEaContainer());
    getEaContainer()->refreshData();
    qDebug() << "photos read " << jsonPictures.count();
}

int EAItemList::insertListItem(int index
                                , int itemType
                                , const QString &title
                                , const QString &imageFileUrl
                                , const QString& textFilenameUrl
                                , const QString& url)
{
    EAItem* newItem;

    switch (itemType) {
    case EAItem::ItemType::Image:
    {
        newItem = new EAItem(itemType, title);
        break;
    }
    case EAItem::ItemType::Document:
    {
        QString textFilename = QUrl(textFilenameUrl).toLocalFile();
        QFile loadFile(textFilename);
        if (!loadFile.open(QIODevice::ReadOnly)) {
            qWarning("Couldn't open save file.");
            return false;
        }
        QByteArray fileData = loadFile.readAll();
        QString fileText(fileData);
        newItem = new EAItem(itemType, title, fileText);
        break;
    }
    case EAItem::ItemType::Url:
        newItem = new EAItem(title, QUrl(url));
        break;
    case EAItem::ItemType::Questions:
        newItem = new EAItem(itemType, title);
        break;
    case EAItem::ItemType::Map:
        newItem = new EAItem(itemType, title);
    default:
        return -1;
    }
    newItem->setEaItemList(this);   
    m_eaItems.insert(index, newItem);
    if (itemType == EAItem::ItemType::Image)
    {
        QString imageFile = QUrl(imageFileUrl).toLocalFile();
        addPicture(index, imageFile);
    }

    getEaContainer()->resetImageProviders();
    emit eaItemListChanged();

    if ( index < 0 )
        return 0;
    else if ( index >= getEaItems().size())
        return getEaItems().size();
    else
        return index;
}

int EAItemList::insertMapItem(int index, const QString &title
                              , const QString &maptype, const QString &token
                              , const QString &mapID, double latitude
                              , double longitude, int zoomLevel, bool useCurrent)
{
    EAItem* newItem;
    newItem = new EAItem(EAItem::ItemType::Map, title);
    m_eaItems.insert(index, newItem);
    EAMap* mapInfo = newItem->mapInfo();
    mapInfo->setMaptype(maptype);
    mapInfo->setAccessToken(token);
    mapInfo->setMapId(mapID);
    mapInfo->setLatitude(latitude);
    mapInfo->setLongitude(longitude);
    mapInfo->setZoomLevel(zoomLevel);
    mapInfo->setUseCurrent(useCurrent);
    resetImageProvider(getEaContainer());

    emit eaItemListChanged();
    if ( index < 0 )
        return 0;
    else if ( index >= getEaItems().size())
        return getEaItems().size();
    else
        return index;
}

int EAItemList::updateListItem(int index
                                , int itemType
                                , const QString &title
                                , const QString &imageFileUrl
                                , const QString &textFilenameUrl
                                , const QString &url)
{
    EAItem* item = m_eaItems[index];
    item->setItemType(itemType);
    item->setTitle(title);
    switch (itemType) {
    case EAItem::ItemType::Image:
    {
        QString imageFile = QUrl(imageFileUrl).toLocalFile();
        addPicture(index, imageFile);
        break;
    }
    case EAItem::ItemType::Document:
    {
        QString textFilename = QUrl(textFilenameUrl).toLocalFile();
        QFile loadFile(textFilename);
        if (!loadFile.open(QIODevice::ReadOnly)) {
            qWarning("Couldn't open save file.");
            return false;
        }
        QByteArray fileData = loadFile.readAll();
        QString fileText(fileData);
        item->setDisplayText(fileText);
        break;
    }
    case EAItem::ItemType::Url:
        item->setUrl(QUrl(url));
        break;
    case EAItem::ItemType::Questions:
        break;
    }
    resetImageProvider(getEaContainer());
    return index;
}

int EAItemList::updateMapItem(int index
                              , const QString &title
                              , const QString &maptype
                              , const QString &token
                              , const QString &mapID
                              , double latitude
                              , double longitude
                              , int zoomLevel
                              , bool useCurrent)
{
    EAItem*  item = m_eaItems[index];
    item->setTitle(title);
    item->setItemType(EAItem::ItemType::Map);
    //item = new EAItem(EAItem::ItemType::Map, title);
    //m_eaItems.insert(index, item);
    EAMap* mapInfo = item->mapInfo();
    mapInfo->setMaptype(maptype);
    mapInfo->setAccessToken(token);
    mapInfo->setMapId(mapID);
    mapInfo->setLatitude(latitude);
    mapInfo->setLongitude(longitude);
    mapInfo->setZoomLevel(zoomLevel);
    mapInfo->setUseCurrent(useCurrent);
    resetImageProvider(getEaContainer());
    return index;
}

void EAItemList::saveAnswers(int itemIndex)
{
    if (m_eaItems.length() > itemIndex
            && getEaContainer()
            && getEaContainer()->user()->loggedOn())
    {
        QList<EaQuestion*> questions = m_eaItems[itemIndex]->getEaQuestions();
        if (questions.length()>0)
        {
            int itemListIndex = getIndex();
            if (itemListIndex !=-1)
                getEaContainer()->saveAnswers(itemListIndex
                                                      , itemIndex
                                                      , questions);
        }
    }
}

void EAItemList::addPicture(int index, const QString& filename)
{
    QImage picImage(filename);
    picImage.scaled(100,100);
    QPixmap pix = QPixmap::fromImage(picImage);
    QJsonValue jsonPic = jsonValFromPixmap(pix);
    /*
    if (jsonPictures.size() > index)
        jsonPictures[index] = jsonPic;
    else if (jsonPictures.size() == index)
        jsonPictures.append(jsonPic);
    else
    {
        QPixmap nullPix;
        QJsonValue nullJson = jsonValFromPixmap(nullPix);
        for ( int i=jsonPictures.size() ; i< index ; i++ )
            jsonPictures.append(nullJson);
        jsonPictures.append(jsonPic);
    }
    //resetImageProvider(getEaContainer());
    */
    padOutPictures();
    jsonPictures[index] = jsonPic;

}

void EAItemList::padOutPictures()
{
    QPixmap nullPix;
    QJsonValue nullJson = jsonValFromPixmap(nullPix);

    int numItems = m_eaItems.size() + jsonData.size();
    for ( int i = jsonPictures.size() ; i<numItems ; i++ )
    {
        jsonPictures.append(nullJson);
    }
}

int EAItemList::useNextItemId()
{
    return nextItemId++;
}

EAContainer *EAItemList::getEaContainer()
{
    return eaContainer;
}

void EAItemList::setEaContainer(EAContainer *value)
{
    eaContainer = value;
}

int EAItemList::getIndex()
{
    QList<EAItemList*> list = getEaContainer()->getEaItemLists();
    for ( int i = 0 ; i < list.length() ; i++ )
    {
        if (list[i] == this)
            return i;
    }
    return -1;
}
/*
void EAItemList::removeItem(int index)
{
    if (0 <= index && index < getEaItems().size())
    {
        //getEaItems().removeAt(index);
        m_eaItems.removeAt(index);
        resetImageProvider(getEaContainer());
        emit eaItemListChanged();
    }
}
*/
void EAItemList::deleteItem(int index)
{
    if (index < m_eaItems.count() && index >= 0)
    {
        m_eaItems.removeAt(index);
        getEaContainer()->resetImageProviders();
        emit eaItemsChnged();
    }
    else
    {
        emit getEaContainer()->error(tr("Error deleting itme")
                    ,tr("Invalid index ") + QString::number(index)
                    ,"EAItemList::deleteItem"
                    , Warning);
    }
}

int EAItemList::moveItem(int index, bool directionUp)
{
    if (index < m_eaItems.count() && index >= 0)
    {
        if (directionUp)
        {
            if (0 == index)
            {
                emit getEaContainer()->error(tr("Error moving item")
                            ,tr("Item already at top of list")
                            ,"EAItemList::moveItem"
                            , Warning);
                return index;
            }
            else
            {
                m_eaItems.swap(index, index -1);
                getEaContainer()->resetImageProviders();
                emit eaItemsChnged();
                return index-1;
            }
        }
        else
        {
            if (m_eaItems.count()-1 == index)
            {
                emit getEaContainer()->error(tr("Error moving itme")
                            ,tr("Item already at bottom of list")
                            ,"EAItemList::moveItem"
                            , Warning);
                return index;
            }
            else
            {
                m_eaItems.swap(index, index +1);
                getEaContainer()->resetImageProviders();
                emit eaItemsChnged();
                return index +1;
            }
        }
    }
    else
    {
        emit getEaContainer()->error(tr("Error moving item")
                    ,tr("Invalid index ") + QString::number(index)
                    ,"EAItemList::moveItem"
                    , Warning);
        return -1;
    }
}

/*
int EAItemList::itemListLength()
{
    return m_eaItems.length();
}*/

QStringList EAItemList::addHeaderFields(const QStringList& fields)
{
    QStringList models;
    for ( int i = 0 ; i < fields.length() ; i++ )
    {
        QString modelName = getModelName(fields[i]);
        if (modelName == "")
            return QStringList();
        else
            models.append(modelName);

        if (!fieldsSet. contains(modelName))
        {
            QJsonObject newField
            {
                { "field", fields[i] },
                { "modelName", modelName },
                { "format", "<html>{0}: {1}<br></html>\n" },
                { "inListView", i==0 ? true : false }
            };
            jsonFields.append(newField);
            fieldsSet.insert(modelName);
            QString nexDefaultText = "<html>{"
                    + QString::number(jsonFields.size())
                    + "}<br></html>\n";
            m_longFormat = m_longFormat + QString(nexDefaultText);
            emit longFormatChanged(m_longFormat);
        }
    }
    setTitleFields(jsonFields);
    return models;
}

QString EAItemList::getModelName(const QString &name) const
{
    int i=0;
    while ( i<name.length() && !name[i].isLetter() )
        i++;
    if ( i< name.length())
    {
        QString rtv = name.right(name.length()-i);
        rtv[0] = rtv[0].toLower();
        return rtv;
    }
    else
        return QString("");
}

QJsonObject EAItemList::newDataItem(const QStringList& speakerData
                                    , const QStringList& header)
{
    QJsonObject newItem;
    QJsonArray newItemArray;
    int headerIndex = 0;
    for ( int i=0 ; i < speakerData.length() ; i++ )
    {
        if (headerIndex >= header.size())
            break;
        newItem[header[headerIndex++]] = speakerData[i];
    }
    for ( int i=0 ; i < jsonFields.size() ; i++ )
    {
        QString header = jsonFields[i].toObject()["modelName"].toString();
        if (newItem[header] == QJsonValue::Undefined)
            newItem[header] = "";
    }
    return newItem;
}
/*
void EAItemList::unpackPhotos() const
{
    for ( int i=0 ; i<jsonPictures.count() ; i++ )
    {
        QPixmap pix = pixmapFrom(jsonPictures[i]);
        QImage image = pix.toImage();
        QString filename = QString::number(i) + ".png";
        image.save(filename, "PNG");
    }
}
*/
// http://stackoverflow.com/questions/32376119/how-to-store-a-qpixmap-in-json-via-qbytearray
QJsonValue jsonValFromPixmap(const QPixmap & p)
{
  QByteArray data;
  QBuffer buffer { &data };
  buffer.open(QIODevice::WriteOnly);
  p.save(&buffer, "PNG");
  auto encoded = buffer.data().toBase64();
  return QJsonValue(QString::fromLatin1(encoded));
}

QPixmap pixmapFrom(const QJsonValue & val)
{
  QByteArray encoded = val.toString().toLatin1();
  QPixmap p;
  p.loadFromData(QByteArray::fromBase64(encoded), "PNG");
  return p;
}

QQmlListProperty<EAItem> EAItemList::items()
{
    return QQmlListProperty<EAItem>(this
                                        , 0 // void *data
                                        , &EAItemList::append_eaItems
                                        , &EAItemList::count_eaItems
                                        , &EAItemList::at_eaItems
                                        , &EAItemList::clear_eaItems
                                        );
}

bool EAItemList::formatedList() const
{
    return m_formatedList;
}

int EAItemList::listType() const
{
    return m_listType;
}

//typedef QQmlListProperty::AppendFunction
//Synonym for void (*)(QQmlListProperty<T> *property, T *value).
//Append the value to the list property.
void EAItemList::append_eaItems(QQmlListProperty<EAItem> *list
                                     , EAItem *itemList)
{
    EAItemList *eaItemColl = qobject_cast<EAItemList *>(list->object);
    if (itemList) {
        //itemList->setParentItem(eaContainer); //???
        eaItemColl->m_eaItems.append(itemList);
    }
}

//typedef QQmlListProperty::CountFunction
//Synonym for int (*)(QQmlListProperty<T> *property).
//Return the number of elements in the list property.
int EAItemList::count_eaItems(QQmlListProperty<EAItem> *list)
{
    EAItemList *eaItemColl = qobject_cast<EAItemList *>(list->object);
    return eaItemColl->m_eaItems.count();
}

//typedef QQmlListProperty::AtFunction
//Synonym for T *(*)(QQmlListProperty<T> *property, int index).
//Return the element at position index in the list property.
EAItem* EAItemList::at_eaItems(QQmlListProperty<EAItem> *list
                                        , int index)
{
    EAItemList *eaItemColl = qobject_cast<EAItemList *>(list->object);
    return eaItemColl->m_eaItems[index];
}

//typedef QQmlListProperty::ClearFunction
//Synonym for void (*)(QQmlListProperty<T> *property).
//Clear the list property.
void EAItemList::clear_eaItems(QQmlListProperty<EAItem> *list)
{
    EAItemList *eaItemColl = qobject_cast<EAItemList *>(list->object);
    eaItemColl->m_eaItems.clear();
}

QList<EAItem *> EAItemList::getEaItems() const
{
    return m_eaItems;
}

void EAItemList::setEaItems(const QList<EAItem *> &eaItems)
{
    m_eaItems = eaItems;
}

bool EAItemList::showIcon()
{
    //EAContainer* eacontianer = getEaContainer();
    //QJsonArray array = getEaContainer()->getJsonIcons();
    //QString icon = array[getIndex()].toString();
    QString icon = getEaContainer()->getJsonIcons()[getIndex()].toString();
    bool m_showIcon =  "" != icon;
    return m_showIcon;
}





















