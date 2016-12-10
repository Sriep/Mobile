import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qrc:///shared"

Item {
    id: formatedListPanel
    width: 1100; height: 800;
    property alias thisItemList: thisItemList
    property alias listItemEntryStack: listItemEntryStack
    property alias listTypeCombo: listTypeCombo
    property alias thisFormatedListPanel: thisFormatedListPanel
    property alias formatedListPanel: formatedListPanel
    property alias ldpEventAppPage: ldpEventAppPage
    Row {
        width: 1100; height: 700
        Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
        Column {
           // width: 1100; height: 700
            Rectangle {
                id: myRect
                width: 500; height: 50
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                border.width : 2; border.color : "blue"
                ComboBox {
                    id: listTypeCombo
                    width: 500; height: 50
                    //currentIndex: 0
                    currentIndex: featuredList.formatedList ? 0 : 1
                    model: [
                        qsTr("Formated list from csv"),
                        qsTr("Manual creation"),
                    ]
                } //ComboBox
            } //Rectangle

            //anchors.top: myRect.anchors.bottom
            clip: true
            Rectangle {
                id: rectSL
                width: 500; height: 700
                border.width : 1; border.color : "green"
                //y: 300
                StackLayout {
                    id: listItemEntryStack
                    width: 500; height: 700
                    currentIndex: listTypeCombo.currentIndex
                    clip: true
                    EaldFormatedList {
                        id: thisFormatedListPanel
                    }
                    EaldList {
                        id: thisItemList
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

        Rectangle {
            id: dataBox
            width: 500; height: 700
            border.width : 0.5; border.color : "black"
            clip: true
            EventAppPage {
                width: parent.width; height: parent.height
                id: ldpEventAppPage
            }
        } //Rectangle
    } //RowLayout

} //Item










































