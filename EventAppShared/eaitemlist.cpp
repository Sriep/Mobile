#include <QJsonObject>
#include <QJsonArray>
#include <QByteArray>
#include "QStringList"
#include <QtQml>
#include <csv.h>
#include <QDebug>

#include "eaitemlist.h"

EAItemList::EAItemList()
{

}

EAItemList::EAItemList(QString name)
    : m_listName(name)
{
    setDataList(jsonData);

    //jsonFields = new QJsonArray();
    QJsonObject dataObject;
    dataObject.insert("headerFields", QJsonValue(jsonFields));
    QJsonDocument jsonDoc(dataObject);
    QByteArray jsonBA = jsonDoc.toJson(QJsonDocument::Compact);
    setTitleFields(jsonBA);
}

void EAItemList::read(const QJsonObject &json)
{
    jsonFields = json["headerFields"].toArray();
    setTitleFields(jsonFields);
    emit titleFieldsChanged(titleFields());

    jsonData = json["dataList"].toArray();
    setDataList(jsonData);
    emit dataListChanged(dataList());

    nextIndex = json["nextIndex"].toInt();
    setListName(json["listName"].toString());
}

void EAItemList::write(QJsonObject &json) const
{
    json["headerFields"] = jsonFields;
    json["dataList"] = jsonData;
    json["listName"] = listName();
    json["nextIndex"] = nextIndex;
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
                { "format", "<html>{0}: {1}</html>\n" },
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





























