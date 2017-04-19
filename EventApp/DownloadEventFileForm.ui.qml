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
    property alias copyClipBut: copyClipBut

    ColumnLayout {
        id: columnLayout2
        width: eventAppMainPage.width
        x:5

        ColumnLayout {
            id: columnLayout1
            width: eventAppMainPage.width
            height: 139
/*
            Label {
                height: 20
                text: eaContainer.eaConstruction.strings.lfDownloadUrl
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }
*/
            TextField {
                id: urlText
                height: 30
                width: eventAppMainPage.width - 20
                //text: "https://www.dropbox.com/s/inpkybii096m5qh/EA%20test1.json?dl=0"
                //text: "https://www.dropbox.com/s/inpkybii096m5qh/EA%20test1.json?raw=1"
                text: "http://www."
                horizontalAlignment: Text.AlignLeft
                Layout.fillWidth: true
                placeholderText: qsTr("https://")
                cursorVisible: true
                selectByMouse: true
                ToolTip.delay: 1000
                ToolTip.timeout: 5000
                ToolTip.visible: hovered
                ToolTip.text:  eaContainer.eaConstruction.strings.lfDownloadUrl
            }

            RowLayout {
                id: rowLayout1
                width: 100
                height: 30
                anchors.left: parent.left
                Button {
                    id: downloadButton
                    text: eaContainer.eaConstruction.strings.bDownlaod
                }
                Button {
                    id: copyClipBut
                    //text: qsTr("Copy from clipboard")
                    text: eaContainer.eaConstruction.strings.copyClipbord
                } //Rectangle
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
            text: eaContainer.eaConstruction.strings.bExit
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
            Flickable {
                anchors.fill: parent
                TextArea.flickable: TextArea {
                    id: debugLog
                    wrapMode: TextArea.Wrap
                    readOnly: true
                }
                ScrollBar.vertical: ScrollBar { }
            }
        }


    }

}
