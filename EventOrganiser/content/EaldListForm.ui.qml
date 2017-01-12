import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0
import "qrc:///shared"
import EventAppData 1.0
Item {
    property alias itmesEntered: itmesEntered
    property alias itemDataType: itemDataType
    property alias itemTitle: itemTitle
    property alias imageEditGroup: imageEditGroup
    property alias addItem: addItem
    property alias itemsModel: itemsModel
    property alias textFilename: textFilename
    property alias urlItem: urlItem
    property alias mouseAreaLV: mouseAreaLV
    property alias deleteBut: deleteBut
    property alias updateItem: updateItem
    property alias clearBut: clearBut    
    property alias mapEditGroup: mapEditGroup

    ColumnLayout {
        id: columnLayout1
        //width: 200; height: 200
        width: parent.width; height: parent.height

        //Item{
        ComboBox {
            id: itemDataType
            currentIndex: 0
            model: [
                qsTr("Image"),
                qsTr("Document"),
                qsTr("External url"),
                qsTr("Questions"),
                qsTr("Map")
            ]
        }
        RowLayout {
            id: rowLayout1
            width: 100
            height: 100

            TextField {
                id: itemTitle
                text: qsTr("")
                selectByMouse: true
            }
            Text {
                id: text1
                text: qsTr("Title")
                font.pixelSize: 12
            }
        }

        EditImageGroup {
            id: imageEditGroup
            visible: itemDataType.currentIndex === EAItem.Image
        }

        RowLayout {
            id: rowLayout3
            width: 100
            height: 100
            visible: itemDataType.currentIndex === 1
            TextField {
                id: textFilename
                text: qsTr("")
                selectByMouse: true
            }
            Label {
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
                text: qsTr("")
                selectByMouse: true
            }
            Label {
                id: text4
                text: qsTr("Url")
                font.pixelSize: 12
            }
        }

        EditMapGroup {
            id: mapEditGroup
            visible: itemDataType.currentIndex === EAItem.Map
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

            Button {
                id: clearBut
                text: qsTr("Clear")
            }
        }
        ListView {
            id: itmesEntered
            width: 110; height: 160

            highlightFollowsCurrentItem: true
            highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
            focus: true

            model: ListModel {
                id: itemsModel
                // Same model as dataListImage.dataImageModel
            }
            delegate: Text {
                height: 30
                text: title
            }
            MouseArea {
                id: mouseAreaLV
                anchors.fill: parent
            }
        }
        // }
    }
}
