import QtQuick 2.7
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import "qrc:///shared"

Page{
    //id: eventAppMainPage
    width: 500; height: 600
    property alias stackCtl: stackCtl
    property alias drawerView: drawerView
    property alias drawerModel: drawerModel
    property alias messageDialog: messageDialog
    //property alias drawerDelegate: drawerDelegate
    clip: true
    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    Rectangle {
        anchors.fill: parent
        //color: eaContainer.eaConstruction.backColour
        color: eaContainer.eaConstruction.display.backColour
        //color:  "white"//eaContainer.eaConstruction.display.backColour
    }
    header: EaToolBar {
        id: toolBar
    }

    footer: EaFooterBar {
        id: footerBar
    }

    MessageDialog {
        id: messageDialog
    }

    StackLayout {
        id: stackCtl
        anchors.fill: parent
        property int topDrawerId: 0
        property int userLoginId: 1
        property int loadEventKey: 2
        property int loadEventFile: 3
        property int loadEventFB: 4
        property int startDrawerId: 5
        property alias drawerModel: drawerModel
        ListView {
            id: drawerView
            property bool isExpanded: false
            anchors.fill: parent
            delegate: ListDelegate {
                id: drawerDelegate
                text: title
                /*Connections {
                    target: eventAppMainPage
                    onDrawerDisplayChanged: drawerDelegate.setDispalyParameters;
                }*/

            }
            model: ListModel {
                id: drawerModel
            }
        }

        UserLogin {
            id: userLogin
        }

        DownloadEventKey {

        }
        DownloadEventFile {

        }
        DownloadEventFB {

        }

        Connections {
            target: eaContainer
            onEaItemListsChanged: refreshLists(stackCtl, drawerModel)
        }
    }
}

