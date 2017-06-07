import QtQuick 2.7
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import "qrc:///shared"

Page {
    //id: eventAppMainPage
    //width: 500; height: 600
    property alias stackCtl: stackCtl
    property alias drawerView: drawerView
    property alias drawerModel: drawerModel
    property alias messageDialog: messageDialog
    property alias toolBar: toolBar
    property alias footerBar: footerBar
    //property alias drawerDelegate: drawerDelegate
    clip: true
    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    Rectangle {
        id: mainPageBkg
        anchors.fill: parent
        color: eaContainer.eaConstruction.display.backColour
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
    AboutDialog {
        width: parent.width
        id: aboutDialog
    }

    StackLayout {
        id: stackCtl
        //anachors.top
        //anchors.top: toolBar.bottom
        //QT5.9 seems to put the stackLayout under the toolBar
        y: parent.y + toolBar.height
        height: parent.height - toolBar.height - footerBar.height
        //height: parent.height
        width: parent.width
        property int topDrawerId: 0
        property int userLoginId: 1
        property int loadEventKey: 2
        property int loadEventFile: 3
        property int loadEventFB: 4
        property int startDrawerId: 5
        property int splashView: 6
        property alias drawerModel: drawerModel
        ListView {
            id: drawerView
            property bool isExpanded: false
            anchors.fill: parent
            delegate: ListDelegate {
                id: drawerDelegate
               // text: title
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



    }
}





















