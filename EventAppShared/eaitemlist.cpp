#include <QJsonObject>
#include <QJsonArray>
#include <QByteArray>
#include "QStringList"
#include <QtQml>
#include <csv.h>
#include <QDebug>
#include <QRegExp>
#include <QBuffer>

#include <QQmlEngine>
#include <QtQml>

#include "eaitemlist.h"
#include "picturelistimageprovider.h"


EAItemList::EAItemList()
{
}

EAItemList::EAItemList(const QString &name)
    : EAItemListBase(name)
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

//void EAItemList::clear(QQmlEngine *engine)
void EAItemList::clear(EAContainer* eacontainer)
{
    EAItemList::clear(eacontainer);
    //resetImageProvider();
}


void EAItemList::resetImageProvider(EAContainer* eacontainer)
{
    QQmlEngine* engine = qmlEngine(getContainer());
    if (engine)
    {
        QQmlImageProviderBase* provider = engine->imageProvider(listName());
        if (!provider)
        {
            PictureListImageProvider* provider
                    = new PictureListImageProvider(jsonPictures);
            engine->addImageProvider(listName(), provider);
        }
    }
}


//void EAItemList::read(const QJsonObject &json, EAContainer* eacontainer)//QQmlEngine *engine)
void EAItemList::read(const QJsonObject &json, QQmlEngine *engine)
{
    //EAItemListBase::read(json, eacontainer);//engine);
    EAItemListBase::read(json, engine);

    jsonFields = json["headerFields"].toArray();
    setTitleFields(jsonFields);
    emit titleFieldsChanged(titleFields());

    jsonData = json["dataList"].toArray();
    setDataList(jsonData);
    emit dataListChanged(dataList());

    setShortFormat(json["shortFormat"].toString());
    setLongFormat(json["longFormat"].toString());
    setFormatedList(json["formatedList"].toBool());

    nextIndex = json["nextIndex"].toInt();
    //setListName(json["listName"].toString());
    setShowPhotos(json["showPhotos"].toBool());
    jsonPictures = json["pictures"].toArray();

    //resetImageProvider(eacontainer);
    //QQmlEngine*  engine = qmlEngine(this);
    if (engine)
    {
        QQmlImageProviderBase* provider = engine->imageProvider(listName());
        if (!provider)
        {
            PictureListImageProvider* provider
                    = new PictureListImageProvider(jsonPictures);
            engine->addImageProvider(listName(), provider);
        }
    }
}

void EAItemList::write(QJsonObject &json) const
{
    json["headerFields"] = jsonFields;
    json["dataList"] = jsonData;
    //json["listName"] = listName();
    json["nextIndex"] = nextIndex;
    json["showPhotos"] = m_showPhotos;
    json["pictures"] = jsonPictures;
    json["formatedList"] = formatedList();
    json["shortFormat"] = shortFormat();
    json["longFormat"] = longFormat();

    EAItemListBase::write(json);
}

QString EAItemList::titleFields() const
{
    return m_titleFields;
}

QString EAItemList::dataList() const
{
    return m_dataList;
}
/*
QString EAItemList::listName() const
{
    return m_listName;
}
*/
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
/*
void EAItemList::setListName(QString listName)
{
    if (m_listName == listName)
        return;

    m_listName = listName;
    emit listNameChanged(listName);
}
*/
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

bool EAItemList::readCSV(const QString filename)
{
    QList<QStringList> csvListLines = CSV::parseFromFile(filename);
    if (csvListLines.length() > 0 )
    {
        QStringList headerList = csvListLines[0];
        QStringList headerModels = addHeaderFields(headerList);
        if (headerModels.length() == 0)
            return false;

        if (csvListLines.length() > 1)
        {
            for ( int line=1 ; line < csvListLines.length() ; line++ )
            {
                QJsonObject newItem = newDataItem(csvListLines[line], headerModels);
                newItem["id"] = nextIndex++;
                jsonData.append(newItem);
            }
            setDataList(jsonData);
        }
        return true;
    }
    else
    {
        return false;
    }

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
        picImage.scaled(100,100);
        QPixmap pix = QPixmap::fromImage(picImage);
        QJsonValue jsonPic = jsonValFromPixmap(pix);
        if (jsonPictures.size() > i)
            jsonPictures[i] = jsonPic;
        else
            jsonPictures.append(jsonPic);
    }
    //resetImageProvider(getContainer());
    qDebug() << "photos read " << jsonPictures.count();
}

void EAItemList::insertListItem(int index
                                , int itemType
                                , const QString &title
                                , const QString &data)
{
    EAItem* newItem = new EAItem(itemType, title, data);
    m_eaItems.insert(index, newItem);
    emit eaItemListChanged();
}

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

        if (!fieldsSet.contains(modelName))
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

QQmlListProperty<EAItem> EAItemList::itemList() const
{
    return m_items;
}

bool EAItemList::formatedList() const
{
    return m_formatedList;
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





















