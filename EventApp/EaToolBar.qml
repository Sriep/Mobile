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

        Connections {
            target: menuListView
            onUpadeteDisplay: {
                console.log("onUpadeteDisplay");
            }
        }
        Connections {
            target: eaContainer
            onEaConstructionChanged: {
                console.log("onEaConstructionChanged");
            }
        }

        ListView {
            id: menuListView
            currentIndex: -1
            anchors.fill: parent
            signal upadeteDisplay()

            delegate: MenuItemDelegate {
                id: menuItemDelegate

                Connections {
                    target: eaContainer
                    onEaConstructionChanged: {
                        setMenuListDisplayParameters();
                    }
                }                
                Connections {
                    target: drawer
                    onOpen: {
                        setMenuListDisplayParameters();
                    }
                }
                Connections {
                    target: menuListView
                    onUpadeteDisplay: {
                        setMenuListDisplayParameters();
                    }
                }
                
            }
            model: stackCtl.drawerModel

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    function setToolBarDisplayParameters() {
        console.log("setToolBarDisplayParameters");
        var displayData = eaContainer.eaConstruction.display;
        var rectangle = dataDelegate.itemBackground;
        var itemTextv = dataDelegate.topText;

        itemBackground.x = eaContainer.eaConstruction.toolBarDisplay.x
        itemBackground.y = eaContainer.eaConstruction.toolBarDisplay.x
        //itemBackground.width = parent.width - x*2;
        //itemBackground.height = parent.height - y*2
        itemBackground.color = eaContainer.eaConstruction.toolBarDisplay.colour
        itemBackground.border.color = eaContainer.eaConstruction.toolBarDisplay.borderColour
        itemBackground.border.width = eaContainer.eaConstruction.toolBarDisplay.borderWidth
        itemBackground.radius = eaContainer.eaConstruction.toolBarDisplay.radius

        titleLabel.font = eaContainer.eaConstruction.toolBarDisplay.font
        titleLabel.color = eaContainer.eaConstruction.toolBarDisplay.fontColour
        titleLabel.style = eaContainer.eaConstruction.toolBarDisplay.textStyle
        titleLabel.styleColor = eaContainer.eaConstruction.toolBarDisplay.styleColour
        titleLabel.x = eaContainer.eaConstruction.toolBarDisplay.xText
        titleLabel.y = eaContainer.eaConstruction.toolBarDisplay.yText
        titleLabel.verticalAlignment = eaContainer.eaConstruction.toolBarDisplay.vAlignment
        titleLabel.horizontalAlignment = eaContainer.eaConstruction.toolBarDisplay.hAlignment

    }

}











































