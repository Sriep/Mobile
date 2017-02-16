#include <QJsonObject>

#include "eainfo.h"

EAInfo::EAInfo()
{
    setEventName("");
}

void EAInfo::read(const QJsonObject &json)
{
       setEventName(json["name"].toString());
       setEventDescription(json["description"].toString());
       setOrganiserName(json["organizer_name"].toString());
       setOrganiserDescription(json["organizer_description"].toString());
}

void EAInfo::write(QJsonObject &json) const
{
    json["name"] = m_eventName;
    json["description"] = m_eventDescription;
    json["organizer_name"] = m_organiserName;
    json["organizer_description"] = m_organiserDescription;
}

QString EAInfo::eventName() const
{
    return m_eventName;
}

QString EAInfo::eventDescription() const
{
    return m_eventDescription;
}

QString EAInfo::organiserName() const
{
    return m_organiserName;
}

QString EAInfo::organiserDescription() const
{
    return m_organiserDescription;
}

void EAInfo::setEventName(QString eventName)
{
    if (m_eventName == eventName)
        return;

    m_eventName = eventName;
    emit eventNameChanged(eventName);
}

void EAInfo::setEventDescription(QString eventDescription)
{
    if (m_eventDescription == eventDescription)
        return;

    m_eventDescription = eventDescription;
    emit eventDescriptionChanged(eventDescription);
}

void EAInfo::setOrganiserName(QString organiserName)
{
    if (m_organiserName == organiserName)
        return;

    m_organiserName = organiserName;
    emit organiserNameChanged(organiserName);
}

void EAInfo::setOrganiserDescription(QString organiserDescription)
{
    if (m_organiserDescription == organiserDescription)
        return;

    m_organiserDescription = organiserDescription;
    emit organiserDescriptionChanged(organiserDescription);
}
