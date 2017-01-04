import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3


Item {
    property alias downloadFromKey: downloadFromKey
    property alias getDebugLog: getDebugLog
    property alias progressKeyDL: progressKeyDL
    property alias downloadKeyBut: downloadKeyBut
    property alias quitButton: quitButton
    property alias debugLog: debugLog

    ColumnLayout {
        id: columnLayout3
        width: 442
        height: 100

        RowLayout {
            id: rowLayout2
            width: 100
            height: 30

            Label {
                id: keyText
                text: qsTr("Download from key")
                font.pixelSize: 12
            }
            TextField {
                id: downloadFromKey
                text: qsTr("4455")
            }
            Button {
                visible: false
                id: getDebugLog
                text: qsTr("Debug log")
            }
        }

        RowLayout {
            id: rowLayout3
            width: 100
            height: 30

            Button {
                id: downloadKeyBut
                text: qsTr("Download from key")
            }
        }

        ProgressBar {
            id: progressKeyDL
            width: 400
            antialiasing: true
            visible: false
            clip: false
            value: 0
            Layout.fillWidth: true
        }
        Button {
            id: quitButton
            text: qsTr("Exit")
        }

        Rectangle {
            width: 450; height: 300
            border.width : 0.5
            border.color : "black"
            anchors.left: parent.left
            anchors.leftMargin: 0
            visible: false
            //anchors.bottom: saveTitlesBut.top rowLayout1.top??
            Flickable {
                anchors.fill: parent
                TextArea.flickable: TextArea {
                    id: debugLog
                    wrapMode: TextArea.Wrap
                    readOnly: true
                }
                ScrollBar.vertical: ScrollBar { }
            }
        } //Rectangle
    }
}
