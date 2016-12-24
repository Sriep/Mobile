import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qrc:///shared"
Item {
    property alias itemDataType: itemDataType
    property alias itemTitle: itemTitle
    property alias itemData: itemData
    property alias addItem: addItem
    property alias textFilename: textFilename
    property alias urlItem: urlItem
    property alias deleteBut: deleteBut
    property alias updateItem: updateItem

    ColumnLayout {
        id: columnLayout1
        width: 200
        height: 200

        //Item{
        ComboBox {
            id: itemDataType
            currentIndex: featuredItem !== undefined ? featuredItem.itemType : 0;
            model: [
                qsTr("Image"),
                qsTr("Document"),
                qsTr("External url"),
                qsTr("Questions")
            ]
        }/*
        ListView {
            id: questionsEntered
            //width: 110; height: 3 === itemDataType.currentIndex ? 160 : 0
            width: 110; height:1603

            highlightFollowsCurrentItem: true
            highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
            focus: true

            model: ListModel {
                id: questionsModel
            }
            delegate: Text {
                //height: 3 === itemDataType.currentIndex ? 30 : 0
                height: 30
                text: title
            }
            MouseArea {
                id: mouseAreaQLV
                anchors.fill: parent
            }
        }*/

        RowLayout {
            id: rowLayout1
            width: 100
            height: 100

            TextField {
                id: itemTitle
                text: featuredItem !== undefined ? featuredItem.title : "";
            }
            Text {
                id: text1
                text: qsTr("Title")
                font.pixelSize: 12
            }
        }
        RowLayout {
            id: rowLayout2
            width: 100
            height: 100
            visible: itemDataType.currentIndex === 0
            TextField {
                id: itemData
                text: qsTr("")
            }
            Text {
                id: text2
                text: qsTr("Image filename")
                font.pixelSize: 12
            }
        }
        RowLayout {
            id: rowLayout3
            width: 100
            height: 100
            visible: itemDataType.currentIndex === 1
            TextField {
                id: textFilename
                text: featuredItem !== undefined ? featuredItem.displayText : "";
            }
            Text {
                id: text3
                text: qsTr("Text/Html filenmae")
                font.pixelSize: 12
            }
        }
        RowLayout {
            id: rowLayout4
            width: 100
            height: 100
            visible: itemDataType.currentIndex === 2
            TextField {
                id: urlItem
                text: featuredItem !== undefined ? featuredItem.urlString : "";
            }
            Text {
                id: text4
                text: qsTr("Url")
                font.pixelSize: 12
            }
        }
        RowLayout {
            id: rowLayout5
            width: 100
            height: 100

            Button {
                id: updateItem
                text: qsTr("Update")
            }

            Button {
                id: addItem
                text: qsTr("Add new")
            }

            Button {
                id: deleteBut
                text: qsTr("Delete")
            }
        }
       // }
    }

}
