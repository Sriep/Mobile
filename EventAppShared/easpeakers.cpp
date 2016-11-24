#include <QJsonObject>
#include <QJsonArray>
#include <QByteArray>

#include "ealistmodel.h"
#include "easpeakers.h"

EASpeakers::EASpeakers()
{

}

void EASpeakers::read(const QJsonObject &json)
{
    setDelegateList(json["fields"].toString());
    jsonFields = json["fields"].toArray();
    for ( int i = 0 ; i < jsonFields.size() ; i++ )
    {
        QJsonObject fieldDeligatePair = jsonFields[i].toObject();
        fieldsSet.insert(fieldDeligatePair["field"].toString());
    }

    QJsonArray speakersArray = json["speakersList"].toArray();
    listModal()->read(speakersArray);
    emit listModalChanged(listModal());
}

void EASpeakers::write(QJsonObject &json) const
{
    json["fields"] = delegateList();

    QJsonArray speakersArray;
    listModal()->write(speakersArray);
    json["speakersList"] = speakersArray;
}

QString EASpeakers::delegateList() const
{
    return m_delegateList;
}

EAListModel *EASpeakers::listModal() const
{
    return m_listModal;
}

void EASpeakers::setDelegateList(QString delegateList)
{
    if (m_delegateList == delegateList)
        return;

    m_delegateList = delegateList;
    emit delegateListChanged(delegateList);
}

void EASpeakers::setListModal(EAListModel *listModal)
{
    if (m_listModal == listModal)
        return;

    m_listModal = listModal;
    emit listModalChanged(listModal);
}

void EASpeakers::readCSV(const QString filename)
{
    QFile file(filename);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << file.errorString();
        return;
    }

    QList<QByteArray> headerList;
    if (!file.atEnd())
    {
        QByteArray header = file.readLine();
        headerList = header.split(seperator);
        addHeaderFields(headerList);
    }
    QJsonArray newListData;
    while (!file.atEnd()) {
        QByteArray line = file.readLine();
        newListData.append(newDataItem(line.split(seperator), headerList));
    }
    listModal()->append(newListData);
    return;
}

void EASpeakers::addHeaderFields(const QList<QByteArray>& fields)
{
    //bool fieldAdded = false;
    for ( int i = 0 ; i < fields.length() ; i++ )
    {
        QString field(fields[i]);
        if (!fieldsSet.contains(field))
        {
            QJsonObject newField
            {
                { "field", field },
                { "delegate", "%1: %2" }
            };
            jsonFields.append(newField);
            fieldsSet.insert(field);
            //fieldAdded = true;
        }
    }
}

QJsonObject EASpeakers::newDataItem(const QList<QByteArray>& speakerData
                                    , const QList<QByteArray>& header)
{
    QJsonObject newItem;
    int headerIndex = 0;
    for ( int i = 0 ; i < speakerData.length() ; i++ )
    {
        if (headerIndex >= header.size())
            break;
        QString field(speakerData[i]);
        if (field[0] == textDelimiter)
        {
            QString mergedFields;
            field = field.right(field.size()-1);
            while (field[field.size()-1] != textDelimiter
                   && ++i < speakerData.length())
            {
                mergedFields += field;
                field = speakerData[i];
            }
            mergedFields += field.left(field.size()-1);
            newItem[QString(header[headerIndex++])] = mergedFields;
        }
        else
        {
            newItem[QString(header[headerIndex++])] = field;
        }

    }
    return newItem;
}
