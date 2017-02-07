import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0
import QtQuick.Controls.Styles 1.4

Item {
    property alias textLogin: textLogin
    property alias textLoadfKey: textLoadfKey
    property alias textLoadfFile: textLoadfFile
    property alias textLaodfFirebase: textLaodfFirebase
    property alias textAbout: textAbout
    property alias textMenueExit: textMenueExit
    property alias textUserId: textUserId
    property alias textPasword: textPasword
    property alias textRegister: textRegister
    property alias textLogon: textLogon
    property alias textLogoff: textLogoff
    property alias textDownloadfKey: textDownloadfKey
    property alias textDownliadFIUrl: textDownliadFIUrl
    property alias textFirebaseUrl: textFirebaseUrl
    property alias textDownload: textDownload
    property alias textExitBut: textExitBut
    property alias textAreaAbout: textAreaAbout
    property alias applyStringsBut: applyStringsBut
    property alias textLoggedOff: textLoggedOff


    ColumnLayout {
        id: columnLayout
        width: parent.width; height: parent.height
        RowLayout {
            ComboBox {
                id: stringPageCB
                width: 100
                currentIndex: 0
                model: [
                    qsTr("ToolBar"),
                    qsTr("Options Menu"),
                    qsTr("User dialog"),
                    qsTr("Download Event dialogs"),
                    qsTr("About dialog"),
                ]
            }
            Button {
                id: applyStringsBut
                text: qsTr("Apply")
            }
        }

        StackLayout {
            id: stackLayout
            currentIndex: stringPageCB.currentIndex
            width: parent.width; height: parent.height

            GroupBox {
                //width: 200; height: 200
                title: qsTr("ToolBar strings")

                RowLayout {
                    id: rowLayout
                    width: parent.width; height: 100
                    Label {
                        text: qsTr("Logged off")
                    }

                    TextField {
                        id: textLoggedOff
                        text: eaContainer.eaConstruction.strings.tbLoggedOff
                        selectByMouse: true
                    }
                }
            }

            GroupBox {
                title: qsTr("Options Menu strings")

                GridLayout {
                    id: rowLayout1
                    columns: 2
                    rows: 6
                    Label {
                        text: qsTr("Login")
                    }
                    TextField {
                        id: textLogin
                        text: eaContainer.eaConstruction.strings.mLogin
                        selectByMouse: true
                    }

                    Label {
                        text: qsTr("Load from Key")
                    }
                    TextField {
                        id: textLoadfKey
                        text: eaContainer.eaConstruction.strings.mLoadFKey
                        selectByMouse: true
                    }

                    Label {
                        text: qsTr("Load from file")
                    }
                    TextField {
                        id: textLoadfFile
                        text: eaContainer.eaConstruction.strings.mLoadFFile
                        selectByMouse: true
                    }

                    Label {
                        id: label1
                        text: qsTr("Load from Firbase")
                    }
                    TextField {
                        id: textLaodfFirebase
                        text: eaContainer.eaConstruction.strings.mLoadFFirebase
                        selectByMouse: true
                    }

                    Label {
                        text: qsTr("About")
                    }
                    TextField {
                        id: textAbout
                        text: eaContainer.eaConstruction.strings.mAbout
                        selectByMouse: true
                    }

                    Label {
                        id: label
                        text: qsTr("Exit")
                    }
                    TextField {
                        id: textMenueExit
                        text: eaContainer.eaConstruction.strings.mExit
                        selectByMouse: true
                    }
                }
            }

            GroupBox {
                title: qsTr("User dialog strings")
                GridLayout {
                    columns: 2
                    rows: 5
                    Label {
                        text: qsTr("UserId")
                    }
                    TextField {
                        id: textUserId
                        text: eaContainer.eaConstruction.strings.lUserId
                        selectByMouse: true
                    }

                    Label {
                        text: qsTr("Password")
                    }
                    TextField {
                        id: textPasword
                        text: eaContainer.eaConstruction.strings.lPassword
                        selectByMouse: true
                    }

                    Label {
                        text: qsTr("Register")
                    }
                    TextField {
                        id: textRegister
                        text: eaContainer.eaConstruction.strings.bRegister
                        selectByMouse: true
                    }

                    Label {
                        text: qsTr("Logon")
                    }
                    TextField {
                        id: textLogon
                        text: eaContainer.eaConstruction.strings.bLogin
                        selectByMouse: true
                    }

                    Label {
                        text: qsTr("Logoff")
                    }
                    TextField {
                        id: textLogoff
                        text: eaContainer.eaConstruction.strings.bLogoff
                        selectByMouse: true
                    }
                }

            }

            GroupBox {
                title: qsTr("Load event dialog strings")
                GridLayout {
                    columns: 2
                    rows: 5

                    Label {
                        text: qsTr("Download from key")
                    }
                    TextField {
                        id: textDownloadfKey
                        text: eaContainer.eaConstruction.strings.lkDownlaodFKey
                        selectByMouse: true
                    }

                    Label {
                        text: qsTr("Download from url")
                    }
                    TextField {
                        id: textDownliadFIUrl
                        text: eaContainer.eaConstruction.strings.lfDownloadUrl
                        selectByMouse: true
                    }

                    Label {
                        text: qsTr("Firebase url")
                    }
                    TextField {
                        id: textFirebaseUrl
                        text: eaContainer.eaConstruction.strings.lfFirebaseUrl
                        selectByMouse: true
                    }

                    Label {
                        text: qsTr("Download event")
                    }
                    TextField {
                        id: textDownload
                        text: eaContainer.eaConstruction.strings.bDownlaod
                        selectByMouse: true
                    }

                    Label {
                        text: qsTr("Exit")
                    }
                    TextField {
                        id: textExitBut
                        text: eaContainer.eaConstruction.strings.bExit
                        selectByMouse: true
                    }
                }
            }

            GroupBox {
                title: qsTr("About box text");
                Flickable {
                    anchors.fill: parent
                    TextArea {
                        id: textAreaAbout
                        anchors.fill: parent
                        text: eaContainer.eaConstruction.strings.aboutText
                        wrapMode: TextArea.Wrap
                        cursorVisible: true
                        selectByKeyboard: true
                        selectByMouse: true
                    }
                    ScrollBar.vertical: ScrollBar { }
                }
            }

        }
    }
}

























