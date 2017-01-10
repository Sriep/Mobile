import QtQuick 2.7
import QtQuick.Controls 2.0

EaToolBarForm {
    id: toolBar
    //titleLabel.text: eaContainer.eaInfo.eventName
    //userLable.text: eaContainer.user.loggodOn ? eaContainer.user.user : "logged off"
    drawerButton.onClicked: {
        drawer.open()
    }

    userBut.onClicked: {
        stackCtl.currentIndex = stackCtl.userLoginId;
    }

    menuButton.onClicked: optionsMenu.open()
    Menu {
        id: optionsMenu
        x: parent.width - width
        transformOrigin: Menu.TopRight
        MenuItem {
            text: qsTr("Login")
            onTriggered: stackCtl.currentIndex = stackCtl.userLoginId;
            visible: !eaContainer.isEventStatic
        }
        MenuItem {
            id: menuItemLoadEventKey
            text: qsTr("Load from Key")
            onTriggered: stackCtl.currentIndex = stackCtl.loadEventKey;
        }
        MenuItem {
            id: menuItemLoadEventFile
            text: qsTr("Load from file")
            onTriggered: stackCtl.currentIndex = stackCtl.loadEventFile;
        }
        MenuItem {
            id: menuItemLoadEventFB
            text: qsTr("Load from Firebase")
            onTriggered: stackCtl.currentIndex = stackCtl.loadEventFB;
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

    Drawer {
        id: drawer
        width: Math.min(eventAppMainPage.width, eventAppMainPage.height) / 3 * 2
        height: eventAppMainPage.height
        background: Rectangle {
            color: eaContainer.eaConstruction.menuDisplay.backColour
        }

        ListView {
            id: menuListView
            currentIndex: -1
            anchors.fill: parent

            delegate: MenuItemDelegate {
                id: menuItemDelegate
            }
            model: stackCtl.drawerModel

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

}



