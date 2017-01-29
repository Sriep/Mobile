import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import "qrc:///shared"

Item {
    property alias addListBut: addListBut
    property alias newListName: newListName
    property alias listsCreated: listsCreated
    property alias listType: listType
    property alias mouseAreaLC: mouseAreaLC
    property alias listsModel: listsModel
    property alias newListBut: newListBut
    property alias updateListBut: updateListBut
    property alias deleteItemListBut: deleteItemListBut
    property alias downItemListBut: downItemListBut
    property alias upItemListBut: upItemListBut

    ColumnLayout {
        id: columnLayout2
        width: 200; height: 200

        GroupBox {
            id: groupBox1
            width: 250; height: 250
            //Layout.alignment: Qt.AlignLeft| Qt.AlignTop
            title: qsTr("Add new list")

            ColumnLayout {
                id: columnLayout1
                width: 100
                height: 100

                ComboBox {
                    id: listType
                    currentIndex: 0
                    model: [
                        qsTr("Load csv"),
                        qsTr("Manual entry")
                    ]
                }
                TextField {
                    id: newListName
                    text: ""
                    placeholderText: qsTr("New list title")
                    cursorVisible: true
                    selectByMouse: true
                }

                RowLayout {
                    id: rowLayout1
                    width: 100
                    height: 100

                    Button {
                        id: newListBut
                        text: qsTr("Clear")
                        visible: true
                    }

                    Button {
                        id: addListBut
                        visible: true
                        enabled: newListName.text !== "" && listType.currentIndex >= 0
                        text: qsTr("+ Add")
                    }

                    Button {
                        id: updateListBut
                        text: qsTr("Update")
                        visible: false
                    }
                }
            }
        }
        /*
        ListView {
            id: listsCreated
            width: 110; height: 160

            highlightFollowsCurrentItem: true
            highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
            focus: true

            model: ListModel {
                id: listsModel
                // Same model as eventAppMainPage.stackCtl.drawerView.drawerModel
            }
            delegate: Label {
                height: 30
                text: listName
            }
            MouseArea {
                id: mouseAreaLC
                anchors.fill: parent
            }
        }
        */
        GroupBox {
            width: parent.width; height: 300
            title: "Item lists"
            //visible: itemDataType.currentIndex === -1
            ColumnLayout {
                Rectangle {
                    border.color: "black"
                    border.width: 1
                    width: 300; height: 250
                    clip: true
                    ListView {
                        id: listsCreated
                        y: 10
                        x: 10
                        //width: 110; height: 160
                        width: parent.width-20; height: parent.height
                        highlightFollowsCurrentItem: true
                        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                        focus: true
                        model: ListModel {
                            id: listsModel
                            // Same model as dataListImage.dataImageModel
                        }
                        delegate: Label {
                            y:10
                            height: 30
                            text: listName
                        }
                        MouseArea {
                            id: mouseAreaLC
                            anchors.fill: parent
                        }
                    }
                }

                RowLayout {
                    id: rowLayout2
                    //width: 100
                    height: 100

                    Button {
                        id: upItemListBut
                        text: qsTr("Move up")
                    }

                    Button {
                        id: downItemListBut
                        text: qsTr("Move down")
                    }
                    Button {
                        id: deleteItemListBut
                        text: qsTr("Delete")
                    }
                }
            }
        }
    }

}
