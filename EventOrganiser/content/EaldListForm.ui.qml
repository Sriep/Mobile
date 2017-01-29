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
    property alias updateItem: updateItem
    property alias clearBut: clearBut
    property alias mapEditGroup: mapEditGroup
    property alias itemNameTA: itemNameTA
    property alias updateTitleBut: updateTitleBut
    property alias downItemBut: downItemBut
    property alias deleteItemBut: deleteItemBut
    property alias upItemBut: upItemBut

    ColumnLayout {
        id: columnLayout1
        width: parent.width; height: parent.height
        RowLayout {
            id: rowLayout
            width: parent.width
            height: 100
            Button {
                id: updateTitleBut
                text: qsTr("Update")
                onPressed: featuredList.listName = itemNameTA.text;
            }
            TextField {
                id: itemNameTA
                width: parent.width - updateTitleBut.width -10
            }

        }
        GroupBox {
            y:5
            width: parent.width -20
            title: "Add new Item information"
            ColumnLayout {
                ComboBox {
                    id: itemDataType
                    currentIndex: -1
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
                    visible: itemDataType.currentIndex === EAItem.Document
                    FileDialog {
                        id: loadDoc
                        fileMode: FileDialog.OpenFile
                        selectedNameFilter.index: 0
                        nameFilters: [ "Text files (*.txt *.html *.* .*)"]
                        folder: eaContainer.workingDirectory
                        Connections {
                            onAccepted: textFilename.text = loadDoc.file;
                        }
                    }
                    Label {
                        text: qsTr("Text/Html filenmae")
                    }
                    TextField {
                        id: textFilename
                        text: qsTr("")
                        selectByMouse: true
                    }
                    Button  {
                        id: imageFile
                        text: qsTr("Load document")
                        Connections {
                            onPressed: loadDoc.open()
                        }
                    }

                }
                RowLayout {
                    id: rowLayout4
                    width: 100
                    height: 100
                    visible: itemDataType.currentIndex === EAItem.Url
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
                        visible: false
                    }

                    Button {
                        id: addItem
                        text: qsTr("Add new")
                    }

                    Button {
                        id: clearBut
                        text: qsTr("Clear")
                    }
                }
            }
        }

        GroupBox {
            width: parent.width; height: 300
            title: "Item lists"
            visible: itemDataType.currentIndex === -1
            ColumnLayout {
                Rectangle {
                    border.color: "black"
                    border.width: 1
                    width: 300; height: 250
                    clip: true
                    ListView {
                        id: itmesEntered
                        y: 10
                        x: 10
                        //width: 110; height: 160
                        width: parent.width-20; height: parent.height
                        scale: 0.01
                        highlightFollowsCurrentItem: true
                        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                        focus: true
                        model: ListModel {
                            id: itemsModel
                        }
                        delegate: Text {
                            y:10
                            height: 30
                            text: title
                        }
                        MouseArea {
                            id: mouseAreaLV
                            anchors.fill: parent
                        }
                    }
                }

                RowLayout {
                    id: rowLayout2
                    //width: 100
                    height: 100

                    Button {
                        id: upItemBut
                        text: qsTr("Move up")
                    }

                    Button {
                        id: downItemBut
                        text: qsTr("Move down")
                    }
                    Button {
                        id: deleteItemBut
                        text: qsTr("Delete")
                    }
                }
            }
        }


    }
}
