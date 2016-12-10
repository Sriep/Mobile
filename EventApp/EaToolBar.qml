import QtQuick 2.7
import QtQuick.Controls 2.0

EaToolBarForm {
    id: toolBar
    titleLabel.text: eaContainer.eaInfo.eventName
    drawerButton.onClicked: {
        drawer.open()
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
                        stackCtl.currentIndex = position + 2;
                        titleLabel.text = model.title
                        //stackView.replace(model.source)
                    }
                    drawer.close();
                }
            }
            model: stackCtl.drawerModel

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

}



