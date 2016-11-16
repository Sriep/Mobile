#include "eventinfo.h"

EventInfo::EventInfo()
{

}

QString EventInfo::eventName() const
{
    return m_eventName;
}

QString EventInfo::eventDescription() const
{
    return m_eventDescription;
}

QString EventInfo::organiserName() const
{
    return m_organiserName;
}

QString EventInfo::organiserDescription() const
{
    return m_organiserDescription;
}

void EventInfo::setEventName(QString eventName)
{
    if (m_eventName == eventName)
        return;

    m_eventName = eventName;
    emit eventNameChanged(eventName);
}

void EventInfo::setEventDescription(QString eventDescription)
{
    if (m_eventDescription == eventDescription)
        return;

    m_eventDescription = eventDescription;
    emit eventDescriptionChanged(eventDescription);
}

void EventInfo::setOrganiserName(QString organiserName)
{
    if (m_organiserName == organiserName)
        return;

    m_organiserName = organiserName;
    emit organiserNameChanged(organiserName);
}

void EventInfo::setOrganiserDescription(QString organiserDescription)
{
    if (m_organiserDescription == organiserDescription)
        return;

    m_organiserDescription = organiserDescription;
    emit organiserDescriptionChanged(organiserDescription);
}
