#include <QJsonObject>
#include <QJsonArray>
#include <QByteArray>
#include "QStringList"
#include <QtQml>
#include <csv.h>
#include <QDebug>

#include "ealistmodel.h"
#include "easpeakers.h"

EASpeakers::EASpeakers()
{

}

void EASpeakers::read(const QJsonObject &json)
{
    jsonFields = json["headerFields"].toArray();
    setTitleFields(jsonFields);
    emit listModalChanged(listModal());

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

EAListModel *EASpeakers::listModal() const
{
    return m_listModal;
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

void EASpeakers::setTitleFields(const QJsonArray &titleFields)
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

void EASpeakers::setListModal(EAListModel *listModal)
{
    if (m_listModal == listModal)
        return;

    m_listModal = listModal;
    emit listModalChanged(listModal);
}

void EASpeakers::setDataList(QString dataList)
{
    if (m_dataList == dataList)
        return;

    m_dataList = dataList;
    emit dataListChanged(dataList);
}

void EASpeakers::readCSV(const QString filename)
{
    QList<QStringList> csvListLines = CSV::parseFromFile(filename);
    if (csvListLines.length() > 0 )
    {
        QStringList headerList = csvListLines[0];
        addHeaderFields(headerList);
        if (csvListLines.length() > 1)
        {
            for ( int line=1 ; line < csvListLines.length() ; line++ )
            {
                QJsonObject newItem = newDataItem(csvListLines[line], headerList);
                newItem["id"] = nextIndex++;
                jsonData.append(newItem);
            }
            setDataList(jsonData);
        }
    }
}

void EASpeakers::addHeaderFields(const QStringList& fields)
{

    for ( int i = 0 ; i < fields.length() ; i++ )
    {
        if (!fieldsSet.contains(fields[i]))
        {
            QJsonObject newField
            {
                { "field", fields[i] },
                { "delegate", "%1: %2" },
                { "inListView", i==0 ? true : false }
            };
            jsonFields.append(newField);
            fieldsSet.insert(fields[i]);
        }
    }


    setTitleFields(jsonFields);

}

QJsonObject EASpeakers::newDataItem(const QStringList& speakerData
                                    , const QStringList& header)
{
    QJsonObject newItem;
    int headerIndex = 0;
    for ( int i = 0 ; i < speakerData.length() ; i++ )
    {
        if (headerIndex >= header.size())
            break;
        newItem[header[headerIndex++]] = speakerData[i];
    }
    return newItem;
}





























