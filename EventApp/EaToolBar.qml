import QtQuick 2.7
import QtQuick.Controls 2.0

EaToolBarForm {
    id: toolBar
    titleLabel.text: eaContainer.eaInfo.eventName
    userLable.text: eaContainer.user.loggodOn ? eaContainer.user.user : "logged off"
    drawerButton.onClicked: {
        drawer.open()
    }

    userBut.onClicked: {

    }

    menuButton.onClicked: optionsMenu.open()
    Menu {
        id: optionsMenu
        x: parent.width - width
        transformOrigin: Menu.TopRight

        MenuItem {
            id: menuItemLoadEvent
            text: qsTr("Load Event")
            onTriggered: stackCtl.currentIndex = stackCtl.loadEventId;
        }
        MenuItem {
            text: qsTr("Login")
            //onTriggered: settingsPopup.open()
            onTriggered: stackCtl.currentIndex = stackCtl.userLoginId;
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

        ListView {
            id: menuListView
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate {
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked: {
                    if (menuListView.currentIndex != index) {
                        menuListView.currentIndex = index;
                        stackCtl.currentIndex = position + stackCtl.startDrawerId
                        titleLabel.text = model.title
                    }
                    drawer.close();
                }
            }
            model: stackCtl.drawerModel

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

}



