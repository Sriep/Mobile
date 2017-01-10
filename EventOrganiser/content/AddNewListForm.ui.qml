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
    property alias deleteListBut: deleteListBut

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

                    Button {
                        id: deleteListBut
                        text: qsTr("Delete")
                        visible: false
                    }

                }
            }
        }
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
    }

}
