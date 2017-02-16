import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import Qt.labs.settings 1.0

TabBar {
    id: headerTabBar
    Layout.minimumWidth: 360
    Layout.minimumHeight: 360
    Layout.preferredWidth: 480
    Layout.preferredHeight: 640
/*
    TabButton {
        text: qsTr("Construction")
    }*/
    TabButton {
        text: qsTr("Data")
    }
    TabButton {
        text: qsTr("Display")
    }
    /*
    TabButton {
        visible: !downloadFileOnly
        text: qsTr("Form answers")
    }
    */
}

/*

        ToolBar {
                leftPadding: 8

                Flow {
                    id: flow
                    width: parent.width

                    Row {
                        id: fileRow
                        ToolButton {
                            id: openButton
                            text: "\uF115" // icon-folder-open-empty
                            font.family: "fontello"
                           // onClicked: openDialog.open()
                        }
                        ToolSeparator {
                            contentItem.visible: fileRow.y === editRow.y
                        }
                    }

                    Row {
                        id: editRow
                        ToolButton {
                            id: copyButton
                            text: "\uF0C5" // icon-docs
                            font.family: "fontello"
                            focusPolicy: Qt.TabFocus
                            //enabled: textArea.selectedText
                            //onClicked: textArea.copy()
                        }
                        ToolButton {
                            id: cutButton
                            text: "\uE802" // icon-scissors
                            font.family: "fontello"
                            focusPolicy: Qt.TabFocus
                           // enabled: textArea.selectedText
                            //onClicked: textArea.cut()
                        }
                        ToolButton {
                            id: pasteButton
                            text: "\uF0EA" // icon-paste
                            font.family: "fontello"
                            focusPolicy: Qt.TabFocus
                           // enabled: textArea.canPaste
                           // onClicked: textArea.paste()
                        }
                        ToolSeparator {
                            contentItem.visible: editRow.y === formatRow.y
                        }
                    }
                }
        }
        */
