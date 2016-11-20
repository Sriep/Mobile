import QtQuick 2.6
import QtQuick.Controls 2.0

EaToolBarForm {

    titleLabel.text: "Whats up folks"

    menuButton.onClicked: optionsMenu.open()
    Menu {
        id: optionsMenu
        x: parent.width - width
        transformOrigin: Menu.TopRight

        MenuItem {
            text: qsTr("Load Event")
            onTriggered: settingsPopup.open()
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



