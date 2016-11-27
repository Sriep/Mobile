#include <QJsonObject>
#include <QJsonArray>
#include <QByteArray>
#include "QStringList"
#include <QtQml>
#include <csv.h>
#include <QDebug>

#include "easpeakers.h"

EASpeakers::EASpeakers()
{

}

void EASpeakers::read(const QJsonObject &json)
{
    jsonFields = json["headerFields"].toArray();
    setTitleFields(jsonFields);
    emit titleFieldsChanged(titleFields());

    jsonData = json["dataList"].toArray();
    setDataList(jsonData);
    emit dataListChanged(dataList());

    nextIndex = json["nextIndex"].toInt();
}

void EASpeakers::write(QJsonObject &json) const
{
    json["headerFields"] = jsonFields;
    json["dataList"] = jsonData;

    json["nextIndex"] = nextIndex;
}

QString EASpeakers::titleFields() const
{
    return m_titleFields;
}

QString EASpeakers::dataList() const
{
    return m_dataList;
}

void EASpeakers::setTitleFields(QString delegateList)
{
    if (m_titleFields == delegateList)
        return;

    m_titleFields = delegateList;
    emit titleFieldsChanged(delegateList);
}

void EASpeakers::setDataList(const QJsonArray &dataListArray)
{
    jsonData = dataListArray;
    QJsonObject dataObject;
    dataObject.insert("dataItems", QJsonValue(jsonData));
    QJsonDocument jsonDoc(dataObject);
    QByteArray jsonBA = jsonDoc.toJson(QJsonDocument::Compact);
    setDataList(QString(jsonBA));
}

QString EASpeakers::listModelFromJson() const
{
    for ( int i=0 ; i < jsonFields.size() ; i++)
    {
        QJsonObject title = jsonFields[i].toObject();

    }

}

void EASpeakers::setTitleFields(const QJsonArray &titleFields)
{
    jsonFields = titleFields;
    QJsonObject titleObject;
    titleObject.insert("headerFields", QJsonValue(jsonFields));
    QJsonDocument jsonDoc(titleObject);
    QByteArray jsonBA = jsonDoc.toJson(QJsonDocument::Compact);
    setTitleFields(QString(jsonBA));

    QString newFileds = "{\"headerFields\":[";
    for ( int i=0 ; i < jsonFields.size() ; i++ )
    {
        QJsonObject jsonField = jsonFields[i].toObject();
        fieldsSet.insert(jsonField["field"].toString());



    }
}

void EASpeakers::setDataList(QString dataList)
{
    if (m_dataList == dataList)
        return;
    m_dataList = dataList;
    emit dataListChanged(dataList);
}

bool EASpeakers::readCSV(const QString filename)
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
    }
    return true;
}

QStringList EASpeakers::addHeaderFields(const QStringList& fields)
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
                { "format", "{0}: {1}" },
                { "inListView", i==0 ? true : false }
            };
            jsonFields.append(newField);
            fieldsSet.insert(modelName);
        }
    }
    setTitleFields(jsonFields);
    return models;
}

QString EASpeakers::getModelName(const QString &name) const
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


QJsonObject EASpeakers::newDataItem(const QStringList& speakerData
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





























