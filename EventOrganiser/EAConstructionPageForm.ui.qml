import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0
import Qt.labs.calendar 1.0

Item {
    property alias loadEventButton: loadEventButton
    property alias saveEventButton: saveEventButton
    //property alias loadFilename: loadFilename
    property alias newEventBut: newEventBut
    property alias downloadBut: downloadBut
    property alias uploadBut: uploadBut
    property alias downloadKey: downloadKey
    property alias firebaseUrlTB: firebaseUrlTB
    property alias firbaseUrlBut: firbaseUrlBut
    property alias linkBut: linkBut
    property alias toCalander: toCalander
    property alias text1: text1
    property alias downloadUrlBtn: downloadUrlBtn
    property alias urlTF: urlTF

    property alias loadFileDialog: loadFileDialog
    property alias saveFileDialog: saveFileDialog

    Flickable {
        Pane {
            id: eventNamePane
            width: parent.width
            ColumnLayout {
                width: parent.width;
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right

                GroupBox {
                    width: parent.width
                    title: qsTr("Data file")
                    ColumnLayout {
                        RowLayout {
                            FileDialog {
                                id: loadFileDialog
                                fileMode: FileDialog.OpenFile
                                selectedNameFilter.index: 0
                                nameFilters: ["Json files (*.json)", "Json binary (*.dat )" ]
                                folder: eaContainer.workingDirectory
                                //onAccepted: settingsData.dataFilename = file
                                Connections {
                                    onAccepted: eaContainer.loadNewEventApp(loadFileDialog.file);
                                }
                            }

                            FileDialog {
                                id: saveFileDialog
                                fileMode: FileDialog.SaveFile
                                defaultSuffix: ".json"
                                selectedNameFilter.index: 0
                                nameFilters:  ["Json files (*.json)", "Json binary (*.dat )" ]
                                folder: eaContainer.workingDirectory
                                //onAccepted: settingsData.dataFilename = file
                                Connections {
                                    onAccepted: eaContainer.saveEventApp(saveFileDialog.file);
                                }
                            }
                        }
                        Button {
                            id: newEventBut
                            text: qsTr("New event")
                            ToolTip.delay: 1000
                            ToolTip.timeout: 5000
                            ToolTip.visible: hovered
                            ToolTip.text: qsTr("Clears current event data, ready to work on a new event.")
                        }
                        RowLayout {
                            id: rowLayout
                            width: 100
                            height: 100
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
                                ToolTip.delay: 1000
                                ToolTip.timeout: 5000
                                ToolTip.visible: hovered
                                ToolTip.text: qsTr("Download event data from the internet.\n"
                                    +  " Assumes we have a suitable raw JSON file at the entered URL.")

                            }
                            Button {
                                id: downloadUrlBtn
                                text: qsTr("Downlaod")
                                Connections {
                                    onPressed: eaContainer.downloadFromUrl(urlTF.text);
                                }
                            }
                        } //RowLayout
                        RowLayout {
                            height: implicitHeight
                            Button {
                                id: loadEventButton
                                text: "Load from file"
                                Connections {
                                    onPressed: loadFileDialog.open()
                                }
                            }
                            Button {
                                id: saveEventButton
                                text: "Save to file"
                                Connections {
                                    onPressed: saveFileDialog.open()
                                }
                            }
                        }

                        RowLayout {
                            id: rowLayout1
                            width: 100
                            height: 100
                            visible: !downloadFileOnly

                            TextField {
                                id: downloadKey
                                //text: qsTr("Text Field")
                                text: settingsData.databaseKey
                                onEditingFinished: settingsData.databaseKey = text;
                                Layout.fillWidth: true
                                cursorVisible: true
                                selectByMouse: true
                            }
                            Text {
                                id: text1
                                text: qsTr("Key")
                                width: 100
                                Layout.fillWidth: true
                                font.pixelSize: 12
                            }
                        }

                        RowLayout {
                            id: rowLayout2
                            width: 100
                            height: 100
                            visible: !downloadFileOnly
                            Button {
                                id: uploadBut
                                text: qsTr("Upload")
                            }

                            Button {
                                id: downloadBut
                                text: qsTr("Download")
                            }
                        }

                        RowLayout {
                            id: rowLayout3
                            width: 300
                            height: 100
                            visible: !downloadFileOnly
                            ColumnLayout {
                                id: columnLayout1
                                width: 300
                                height: 100

                                Button {
                                    id: firbaseUrlBut
                                    text: qsTr("Save firebase url")
                                }
                                TextField {
                                    id: firebaseUrlTB
                                    width: 300; height: 30
                                    text: settingsData.firebaseUrl
                                    onEditingFinished: settingsData.firebaseUrl = text;
                                    Layout.fillWidth: true
                                    cursorVisible: true
                                    selectByMouse: true
                                }
                                Calander57 {
                                    id: toCalander
                                }
                                Button {
                                    id: linkBut
                                    text: qsTr("Link to url")
                                }
                            }
                        }

                        Button {
                            text: qsTr("Help")
                            Connections {
                                onPressed: eaAssistant.startAssistant("file.html");
                            }
                        }
                    } //ColumnLayout
                } //GroupBox

            } // GridLayout
        } // Pane
    } // Flickable
}
