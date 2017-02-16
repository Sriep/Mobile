import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick 2.7
import QtQuick.Controls 2.1


Dialog {
    id: downloadUrlDlg
    title: qsTr("Downlaod file")
    focus: true
    modal: true
    contentItem:  RowLayout {
                    Label {
                        id: label
                        text: qsTr("Download from url")
                    }
                    TextField {
                        id: urlTF
                        placeholderText: "Url"
                        Layout.fillWidth: true
                        cursorVisible: true
                        selectByMouse: true
                    }
                    DialogButtonBox {
                        standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
                        Connections {
                            onAccepted: {
                                eaContainer.downloadFromUrl(urlTF.text);
                                downloadUrlDlg.accept()
                            }
                        }

                        Connections {
                            onRejected: downloadUrlDlg.reject()
                        }
                    }
                }

}
