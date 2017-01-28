import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qrc:///shared"
Item {
    property alias itemDataType: itemDataType
    property alias itemTitle: itemTitle
    property alias imageItemEditGroup: imageIEditGroup
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
            enabled: false
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
                text: featuredItem !== undefined ? featuredItem.title : "";
                cursorVisible: true
                selectByMouse: true
            }
            Text {
                id: text1
                text: qsTr("Title")
                font.pixelSize: 12
            }
        }

        EditImageGroup {
            id: imageIEditGroup
            //visible: itemDataType.currentIndex === EAItem.Image
            visible: itemDataType.currentIndex === 0
        }

        RowLayout {
            id: rowLayout3
            width: 100
            height: 100
            visible: itemDataType.currentIndex === 1
            TextField {
                id: textFilename
                text: featuredItem !== undefined ? featuredItem.displayText : "";
                cursorVisible: true
                selectByMouse: true
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
                cursorVisible: true
                selectByMouse: true
            }
            Text {
                id: text4
                text: qsTr("Url")
                font.pixelSize: 12
            }
        }
        EditMapGroup {
            id: mapEditGroup
            visible: itemDataType.currentIndex === 4
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
                visible: itemDataType.currentIndex === 3
                text: qsTr("Add new")
            }

            Button {
                id: deleteBut
                text: qsTr("Delete")
            }
        }
    }

}
