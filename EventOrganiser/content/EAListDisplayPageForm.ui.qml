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
    //property alias thisFormatedListPanel: thisFormatedListPanel
    //property alias thisItemList: thisItemList

    //property alias listTypeCombo: listTypeCombo
    property alias listItemEntryStack: listItemEntryStack
    property alias dataDisplayTab: dataDisplayTab
    //property alias formatedListPanel: formatedListPanel
    //property alias ldpEventAppPage: ldpEventAppPage
    //RowLayout {
        //width: 1100; height: 700
        //width: parent.width; height: parent.height -100
        //Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
        //spacing: 10
        //x:10; y:10
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
                    text: qsTr("Main")
                }
                TabButton {
                    text: qsTr("Drawer")
                }
                TabButton {
                    text: qsTr("ItemList")
                }
 /*
                TabButton {
                    text: qsTr("Csv file")
                }
                TabButton {
                    text: qsTr("Manual")
                }
                */
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
                    currentIndex: dataDisplayTab.currentIndex
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
/*
                    EaldFormatedList {
                        id: thisFormatedListPanel
                    }
                    EaldList {
                        id: thisItemList
                    }
 */
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










































