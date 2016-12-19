import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    property alias urlText: urlText
    property alias downloadButton: downloadButton
    property alias progressBar: progressBar
    property alias quitButton: quitButton
    property alias progressKeyDL: progressKeyDL
    property alias downloadKeyBut: downloadKeyBut
    property alias downloadFromKey: downloadFromKey

    ColumnLayout {
        id: columnLayout2
        width: 100
        height: 100

        ColumnLayout {
            id: columnLayout1
            width: 445
            height: 139


            Label {
                id: label1
                width: 105
                height: 40
                text: qsTr("Dwonload from url")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }

            TextField {
                id: urlText
                width: 400
                text: "https://www.dropbox.com/s/qvcmm683cq237ig/test2.json"
                horizontalAlignment: Text.AlignLeft
                Layout.fillWidth: true
                placeholderText: qsTr("Text Field")
            }


            RowLayout {
                id: rowLayout1
                width: 100
                height: 100
                anchors.left: parent.left
                anchors.leftMargin: -20


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
            }
        }

        ColumnLayout {
            id: columnLayout3
            width: 100
            height: 100

            RowLayout {
                id: rowLayout2
                width: 100
                height: 100

                Text {
                    id: keyText
                    text: qsTr("Download from key")
                    font.pixelSize: 12
                }

                TextField {
                    id: downloadFromKey
                    text: qsTr("4455")
                }
            }

            RowLayout {
                id: rowLayout3
                width: 100
                height: 100

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
            }
        }

        Button {
            id: quitButton
            text: qsTr("Exit")
        }
    }
}
