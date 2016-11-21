import QtQuick 2.6
import QtQuick.Controls 2.0

EaToolBarForm {
    id: toolBar
    titleLabel.text: eaContainer.eaInfo.eventName

    menuButton.onClicked: optionsMenu.open()
    Menu {
        id: optionsMenu
        x: parent.width - width
        transformOrigin: Menu.TopRight

        MenuItem {
            id: menuItemLoadEvent
            text: qsTr("Load Event")
            onTriggered: mainStack.stackCtl.currentIndex = mainStack.loadEventId;
        }
        MenuItem {
            text: qsTr("Settings")
            onTriggered: settingsPopup.open()
        }
        MenuItem {
            text: qsTr("About")
            onTriggered: aboutDialog.open()
        }
        MenuItem {
            text: qsTr("Exit")
            onTriggered: Qt.quit()
        }
    }

}



