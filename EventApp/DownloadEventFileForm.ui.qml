import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    property alias urlText: urlText
    property alias downloadButton: downloadButton
    property alias quitButton: quitButton
    property alias copyClipBut: copyClipBut    

        Text {
            id: expalinLoadUrl
            width: parent.width
            text: eaContainer.eaConstruction.strings.dlUrlExpalin
            wrapMode: Text.WordWrap  ;//WordWrap WrapAnywhere
        }
        ColumnLayout {
            width: parent.width
            anchors.top: expalinLoadUrl.bottom
            TextField {
                id: urlText
                width: parent.width
                Layout.fillWidth: true
                text: "http://www."
                horizontalAlignment: Text.AlignLeft
                placeholderText: qsTr("https://")
                cursorVisible: true
                selectByMouse: true
            }
            Button {
             //   anchors.top: urlText.bottom
                id: copyClipBut
                //text: qsTr("Copy from clipboard")
                text: eaContainer.eaConstruction.strings.copyClipbord
            }
            RowLayout {
                id: rowLayout1
                width: 100
                height: 30
               // anchors.left: parent.left
              //  anchors.top: copyClipBut.bottom
                Button {
                    id: downloadButton
                    text: eaContainer.eaConstruction.strings.bDownlaod
                }

                Button {
                    id: quitButton
                    text: eaContainer.eaConstruction.strings.bExit
                }
            }
    }
}
