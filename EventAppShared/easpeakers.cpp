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
    setDelegateList(json["delegateList"].toString());

    QJsonArray speakersArray = json["speakersList"].toArray();
    listModal()->read(speakersArray);
    emit listModalChanged(listModal());
}

void EASpeakers::readCSV(const QString filename)
{
    QFile file(filename);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << file.errorString();
        return;
    }

    //QStringList wordList;
    if (!file.atEnd())
    {
        //QStringList fields;
        QByteArray header = file.readLine();
        //fields.append(line.split(',').first());
        addSpeakerFields(QStringList(header.split(',').first()));
    }

    while (!file.atEnd()) {
        QByteArray line = file.readLine();
        //wordList.append(line.split(',').first());
        addSpeaker(QStringList(line.split(',').first()));
    }

    return;
}

void EASpeakers::write(QJsonObject &json) const
{
    json["delegateList"] = delegateList();

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

void EASpeakers::addSpeakerFields(QStringList fields)
{

}

void EASpeakers::addSpeaker(QStringList speakerData)
{

}
