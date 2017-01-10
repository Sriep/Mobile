import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import EventAppData 1.0

EAInfoNameForm {
    textEventName.text: eaContainer.eaInfo.eventName;

    saveInfo.onClicked: {
        eaContainer.eaInfo.eventName = textEventName.text;
    }

    Connections {
      target: eaContainer
      onEaItemListsChanged: {
          textEventName.text = eaContainer.eaInfo.eventName;
      }
    }
}

