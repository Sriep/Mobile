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
    property alias firebaseUrlTF: firebaseUrlTF

    ColumnLayout {
        id: columnLayout3
        //width: 442;  height: 100
        RowLayout {
            id: rowLayout1
            width: eventAppMainPage.width - 20
            height: 30

            Label {
                id: lable3
                text:  eaContainer.eaConstruction.strings.lfFirebaseUrl
                font.pixelSize: 12
            }
            TextField {
                id: firebaseUrlTF
                Layout.fillWidth: true
                //text: "https://????.firebaseio.com/"
                text: "https://mytestproject-be3ee.firebaseio.com/"
                cursorVisible: true
                selectByMouse: true
            }
        }

        RowLayout {
            id: rowLayout2
            width: parent.width
            height: 30
            Label {
                id: keyText
                text: eaContainer.eaConstruction.strings.lkDownlaodFKey
                font.pixelSize: 12
            }
            TextField {
                id: downloadFromKey
                //text: qsTr("4455")
                cursorVisible: true
                selectByMouse: true
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
                text: eaContainer.eaConstruction.strings.bDownlaod
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
            text: eaContainer.eaConstruction.strings.bExit
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
