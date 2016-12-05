#include <QJsonObject>
#include <QJsonArray>
#include <QByteArray>
#include "QStringList"
#include <QtQml>
#include <csv.h>
#include <QDebug>
#include <QRegExp>
#include <QBuffer>
#include "eaitemlist.h"



EAItemList::EAItemList()
{

}

EAItemList::EAItemList(QString name)
    : m_listName(name)
{
    setDataList(jsonData);

    QJsonObject dataObject;
    dataObject.insert("headerFields", QJsonValue(jsonFields));
    QJsonDocument jsonDoc(dataObject);
    QByteArray jsonBA = jsonDoc.toJson(QJsonDocument::Compact);
    setTitleFields(jsonBA);
}

void EAItemList::read(const QJsonObject &json, bool unpack)
{
    jsonFields = json["headerFields"].toArray();
    setTitleFields(jsonFields);
    emit titleFieldsChanged(titleFields());

    jsonData = json["dataList"].toArray();
    setDataList(jsonData);
    emit dataListChanged(dataList());

    nextIndex = json["nextIndex"].toInt();
    setListName(json["listName"].toString());
    setShowPhotos(json["showPhotos"].toBool());
    jsonPictures = json["pictures"].toArray();
    if (unpack) unpackPhotos();
}

void EAItemList::write(QJsonObject &json) const
{
    json["headerFields"] = jsonFields;
    json["dataList"] = jsonData;
    json["listName"] = listName();
    json["nextIndex"] = nextIndex;
    json["showPhotos"] = m_showPhotos;
    json["pictures"] = jsonPictures;
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
        fieldsSet.insert(jsonField["field"].toString());
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
        picImage.scaled(75,75);
        QPixmap pix = QPixmap::fromImage(picImage);
        QJsonValue jsonPic = jsonValFromPixmap(pix);
        if (jsonPictures.size() > i)
            jsonPictures[i] = jsonPic;
        else
            jsonPictures.append(jsonPic);
    }
    qDebug() << "photos read " << jsonPictures.count();
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


























