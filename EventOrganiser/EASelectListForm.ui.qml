import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import "qrc:///shared"

Item {
    property alias addListBut: addListBut
    property alias newListName: newListName
    property alias eventAppPage: eventAppPage
    RowLayout {
        id: rowLayout1
        anchors.fill: parent
        GroupBox {
            id: groupBox1
            width: 200
            height: 200
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            title: qsTr("Add new list")

            ColumnLayout {
                id: columnLayout1
                width: 100
                height: 100


                TextField {
                    id: newListName
                    text: ""
                    placeholderText: qsTr("New list title")
                }
                Button {
                    id: addListBut
                    enabled: newListName.text != ""
                    text: qsTr("+ Add")
                }
            }
        }

        EventAppPage {
            id: eventAppPage
        }
    }
}
