import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qrc:///shared"

Item {
    id: formatedListPanel
    //width: 1100; height: 800;
    width: 600; height: 800;
    property alias thisItemListData: thisItemListData
    property alias listItemEntryStack: listItemEntryStack
    property alias dataDisplayTab: dataDisplayTab
    Column {
        width: parent.width; height: parent.height -100
        spacing: 10
        x:10; y:10
        TabBar {
            //width: parent.width; //height: parent.height
            width: 520
            id: dataDisplayTab
            Layout.minimumWidth: 360
            Layout.preferredWidth: 480
            TabButton {
                text: qsTr("Toolbar")
            }
            TabButton {
                text: qsTr("Drawer")
            }
            TabButton {
                text: qsTr("ItemList")
            }
            TabButton {
                text: qsTr("Item")
            }
        }

        clip: true
        Rectangle {
            id: rectSL
            width: 520; height: 720
            border.width : 1; border.color : "green"
            //y: 300

            StackLayout {
                id: listItemEntryStack
                //currentIndex: dataDisplayTab.currentIndex
                currentIndex: 1
                x:10; y: 10
                //width: 500; height: 700
                width: parent.width - 2*x; height: parent.height - 2*y
                clip: true
                property int formatedListStack: 1
                property int manualListItem: 2
                EAInfoName {
                }

                AddNewList {
                }

                EaItemListData {
                    id: thisItemListData
                }

                EaldItem {
                    id: thisItem
                }

                Rectangle {
                    color: 'blue'
                    implicitWidth: 200
                    implicitHeight: 200
                }
                Rectangle {
                    color: 'green'
                    implicitWidth: 200
                    implicitHeight: 200
                }

            } //StackLayout
        }  //Rectangle
   } //ColumnLayout

} //Item










































