import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import "qrc:///shared"

Page{
    id: eventAppMainPage
    width: 500; height: 600
    property alias stackCtl: stackCtl
    property alias drawerView: drawerView
    property alias downloadEvent: downloadEvent
    property alias drawerModel: drawerModel
    //property alias drawerDelegate: drawerDelegate
    clip: true
    Layout.alignment: Qt.AlignLeft | Qt.AlignTop

    header: EaToolBar {
        id: toolBar
    }

    footer: EaFooterBar {
        id: footerBar
    }

    StackLayout {
        id: stackCtl
        anchors.fill: parent
        property int topDrawerId: 0
        property int loadEventId: 1
        property int userLoginId: 2
        property int startDrawerId: 3
        property alias drawerModel: drawerModel
        ListView {
            id: drawerView
            property bool isExpanded: false
            anchors.fill: parent
            delegate: ListDelegate {
                id: drawerDelegate
                text: title
            }
            model: ListModel {
                id: drawerModel
            }
        }
        DownloadEvent {
            id: downloadEvent
        }
        UserLogin {
            id: userLogin
        }

        Connections {
            target: eaContainer
            onEaItemListsChanged: refreshLists(stackCtl, drawerModel)
        }
    }
}

