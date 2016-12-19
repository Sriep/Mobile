import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4


ToolBar {
    id: toolBar
    property alias drawerButton: drawerButton
    property alias menuButton: menuButton
    property alias titleLabel: titleLabel
    RowLayout {
        spacing: 20
        anchors.fill: parent

        ToolButton {
            id: drawerButton
            contentItem: Image {
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source:  "qrc:///shared/images/drawer@4x.png"
            }
        }

        Label {
            id: titleLabel
            text: "Gallery"
            font.pixelSize: 20
            elide: Label.ElideRight
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            Layout.fillWidth: true
        }

        ToolButton {
            id: menuButton
            contentItem: Image {
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source:  "qrc:///shared/images/menu@4x.png"
            }

        }
    }
}

