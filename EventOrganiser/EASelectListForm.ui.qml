import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
//import "../EventAppShared"
import "qrc:/shared"

Item {
    property alias addListBut: addListBut
    property alias newListName: newListName
    property alias downloadEvent: downloadEvent
    property alias drawerView: drawerView
    property alias drawerModel: drawerModel
    RowLayout {
        id: rowLayout1
        anchors.fill: parent


        GroupBox {
            id: groupBox1
            width: 200
            height: 200
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            title: qsTr("Add new list")

            ColumnLayout {
                id: columnLayout1
                width: 100
                height: 100


                TextField {
                    id: newListName
                    text: ""
                    placeholderText: qsTr("New list title")
                }
                Button {
                    id: addListBut
                    enabled: newListName.text != ""
                    text: qsTr("+ Add")
                }
            }
        }

        Page{
            width: 500
            height: 600
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
                property alias drawerModel: drawerModel
                ListView {
                    id: drawerView
                    //width: 110
                    //height: 160
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
                Connections {
                    target: eaContainer
                    onLoadedEventApp: refreshLists(stackCtl, drawerModel)
                }
            }

        }
    }
}
