import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

Item {
    property alias loadEventButton: loadEventButton
    property alias newEventButton: newEventButton
    property alias continueButton: continueButton
    property alias columnLayout1: columnLayout1

    ColumnLayout {
        id: columnLayout1
        anchors.fill: parent


        Button {
            id: continueButton
            text: qsTr("Continue")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Text {
                id: currentFilename
                x: -278
                y: 106
                text: qsTr("Text")
                font.pixelSize: 12
            }
        }
        Button {
            id: newEventButton
            text: qsTr("New")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }
        Button {
            id: loadEventButton
            text: qsTr("Load")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }
    }
}
