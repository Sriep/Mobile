import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import EventAppData 1.0

EAInfoNameForm {
    eventDescription.width: Math.max(implicitWidth, Math.min(implicitWidth * 3, eventNamePane.availableWidth / 3))
    parentDescription.width: Math.max(implicitWidth, Math.min(implicitWidth * 3, eventNamePane.availableWidth / 3))
    textEventName.text: eventInfo.eventName;
    eventDescription.text: eventInfo.eventDescription;
    textOrgName.text: eventInfo.organiserName;
    parentDescription.text: eventInfo.organiserDescription;
}

