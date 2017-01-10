import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    property alias urlText: urlText
    property alias downloadButton: downloadButton
    property alias progressBar: progressBar
    property alias quitButton: quitButton
    property alias debugLog: debugLog
    property alias getDebugLog: getDebugLog

    ColumnLayout {
        id: columnLayout2
        width: 445
        height: 100
        x:10

        ColumnLayout {
            id: columnLayout1
            width: 445
            height: 139

            Label {
                id: label1
                width: 105
                height: 20
                text: qsTr("Dwonload from url")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }

            TextField {
                id: urlText
                height: 30; width: 400
                //text: "https://www.dropbox.com/s/qvcmm683cq237ig/test2.json"
                //text: "https://www.dropbox.com/s/oh1hwo4oz82jdhi/NewEvent.json"
                text: "https://www.dropbox.com/s/y22jqfwuei1ew70/4455.json?raw=1"
                horizontalAlignment: Text.AlignLeft
                Layout.fillWidth: true
                placeholderText: qsTr("Text Field")
                cursorVisible: true
                selectByMouse: true
            }

            RowLayout {
                id: rowLayout1
                width: 100
                height: 30
                anchors.left: parent.left
                Button {
                    id: downloadButton
                    text: qsTr("Download from url")
                }
            }

            ProgressBar {
                id: progressBar
                width: 400
                antialiasing: true
                visible: false
                clip: false
                value: 0
                Layout.fillWidth: true
            }
        }

        Button {
            id: quitButton
            text: qsTr("Exit")
        }

        Button {
            id: getDebugLog
            visible: false
            text: qsTr("Debug log")
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
