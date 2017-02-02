import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    property alias registerBut: registerBut
    property alias logoffBut: logoffBut
    property alias logonBut: logonBut
    property alias passwordTB: passwordTB
    //property alias emailTB: emailTB
    property alias quitButton: quitButton
    property alias userIdTF: userIdTF

    ColumnLayout {
        id: columnLayout1
        width: 100
        height: 100

        RowLayout {
            id: rowLayout4
            width: 100
            height: 100

            TextField {
                id: userIdTF
                text: qsTr("")
                cursorVisible: true
                selectByMouse: true
            }

            Label {
                id: text4
                text: eaContainer.eaConstruction.strings.lUserId
                //text: qsTr("User id")
                font.pixelSize: 12
            }

        }
/*
        RowLayout {
            id: rowLayout1
            width: 100
            height: 100

            TextField {
                id: emailTB
                text: qsTr("")
                placeholderText: qsTr("a@b.co.uk");
                cursorVisible: true
                selectByMouse: true
                visible: false
            }

            Label {
                id: text2
                text: qsTr("Email")
                font.pixelSize: 12
            }
        }
*/
        RowLayout {
            id: rowLayout2
            width: 100
            height: 100

            TextField {
                id: passwordTB
                text: qsTr("")
                cursorVisible: true
                selectByMouse: true
                echoMode: TextInput.PasswordEchoOnEdit
            }

            Label {
                id: text3
                text: eaContainer.eaConstruction.strings.lPassword
                font.pixelSize: 12
            }
        }

        RowLayout {
            id: rowLayout3
            width: 100
            height: 100

            Button {
                id: registerBut
                text: eaContainer.eaConstruction.strings.bRegister
            }

            Button {
                id: logonBut
                text: eaContainer.eaConstruction.strings.bLogin
            }

            Button {
                id: quitButton
                text: eaContainer.eaConstruction.strings.bExit
            }

            Button {
                id: logoffBut
                text: eaContainer.eaConstruction.strings.bLogoff
            }
        }

    }


}
