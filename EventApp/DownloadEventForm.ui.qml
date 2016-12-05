import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    property alias urlText: urlText
    property alias downloadButton: downloadButton
    property alias progressBar: progressBar
    property alias quitButton: quitButton

    ColumnLayout {
        id: columnLayout1
        x: 25
        y: 20
        width: 445
        height: 139


        Label {
            id: label1
            width: 105
            height: 40
            text: qsTr("Dwonload url")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 12
        }

        TextField {
            id: urlText
            width: 400
            //text: "https://www.dropbox.com/s/okzw27c57d3qy55/data.json"
            //text: "https://www.dropbox.com/s/eydtij5yu12twq0/data1.json"
           // text: "https://www.dropbox.com/s/34bfzm8retlgs5v/data4.json"
            text: "https://www.dropbox.com/s/i3ha04beydsge0m/data5.json?dl=0"
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
                text: qsTr("Download")
            }
            Button {
                id: quitButton
                text: qsTr("Exit")
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
}
