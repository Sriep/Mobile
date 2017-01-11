import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0
import "qrc:///shared"

Item {
    property alias itmesEntered: itmesEntered
    property alias itemDataType: itemDataType
    property alias itemTitle: itemTitle
    property alias itemData: itemData
    property alias addItem: addItem
   // property alias switchFormat: switchFormat
    property alias itemsModel: itemsModel
    property alias textFilename: textFilename
    property alias urlItem: urlItem
    property alias mouseAreaLV: mouseAreaLV
    property alias deleteBut: deleteBut
    property alias updateItem: updateItem
    property alias clearBut: clearBut

    ColumnLayout {
        id: columnLayout1
        //width: 200; height: 200
        width: parent.width; height: parent.height
        FileDialog {
            id: loadImage
            fileMode: FileDialog.OpenFile
            selectedNameFilter.index: 0
            nameFilters: [ "Image files (*.png *.bmp *.jpg *.jpeg *.pbm *.pgm *.ppm *.xbm *.xpm)"]

            /*nameFilters: [
                "png files (*.png)"
                , "bmp files (*.bmp )"
                , "jpg files (*.jpg)"
                , "jpeg files (*.jpeg)"
                , "pbm files (*.pbm)"
                , "pgm files (*.pgm)"
                , "ppm files (*.ppm)"
                , "xbm files (*.xbm)"
                , "xpm files (*.xpm)"
            ]*/
            folder: eaContainer.workingDirectory
            //onAccepted: settingsData.dataFilename = file
            Connections {
                onAccepted: itemData.text = loadImage.file;
            }
        }

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
        RowLayout {
            id: rowLayout2
            width: 100
            height: 100
            visible: itemDataType.currentIndex === 0
            Button  {
                id: imageFile
                text: qsTr("Load image file")
                Connections {
                    onPressed: loadImage.open()
                }
            }

            TextField {
                id: itemData
                text: qsTr("")
                selectByMouse: true
            }
            /*
            Text {
                id: text2
                text: qsTr("Image filename")
                font.pixelSize: 12
            }
*/
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


        CheckBox {
            visible: itemDataType.currentIndex === 4
            id: userMap
            text: qsTr("Use you own map")
        }
        RowLayout {
            visible: itemDataType.currentIndex === 4
            Label {
                id: label1
                text: qsTr("Access token")
                enabled: userMap.checked
            }
            TextField {
                id: textField1
                placeholderText: qsTr("Access token")
                enabled: userMap.checked
                selectByMouse: true
            }
        }
        RowLayout {
            visible: itemDataType.currentIndex === 4
            Label {
                id: label2
                text: qsTr("Map id")
            }
            TextField {
                id: textField2
                text: qsTr("mapbox.mapbox-streets")
                selectByMouse: true
            }
        }
        CheckBox {
            visible: itemDataType.currentIndex === 4
            id: useDevicePosition
            text: qsTr("Use current location")
        }
        RowLayout {
            visible: itemDataType.currentIndex === 4
            Label {
                text: qsTr("Latitude")
                enabled: !useDevicePosition.checked
            }

            TextField {
                id: latitudeTB
                text: qsTr("")
                enabled: !useDevicePosition.checked
                validator: IntValidator {bottom: -90; top: 00;}
                selectByMouse: true
            }

            Label {
                text: qsTr("Longitude")
                enabled: !useDevicePosition.checked
            }
            TextField {
                id: longitudeTF
                text: qsTr("")
                enabled: !useDevicePosition.checked
                validator: IntValidator {bottom: -180; top: 180;}
                selectByMouse: true
            }
        }


        //Button {
        //    id: switchFormat
        //    //visible: false
        //    text: qsTr("Switch from csv")
        //}
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
