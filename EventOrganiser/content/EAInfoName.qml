import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import EventAppData 1.0

EAInfoNameForm {
    textEventName.text: eaContainer.eaInfo.eventName;

    Component.onCompleted: {
        textEventName.activeFocus();
    }

    saveInfo.onClicked: {
        eaContainer.eaInfo.eventName = textEventName.text;
        ldpEventAppPage.resetToTopDrawer();
        appwin.setTitle();
    }

    Connections {
        target: eaContainer
        onEventCleared: {
            textEventName.text = eaContainer.eaInfo.eventName;
            ldpEventAppPage.resetToTopDrawer();
        }
    }

    Connections {
      target: eaContainer
      onEaItemListsChanged: {
          textEventName.text = eaContainer.eaInfo.eventName;
          //ldpEventAppPage.resetToTopDrawer();
      }
    }

    newEventButIF.onClicked: eaContainer.clearEvent();
}

