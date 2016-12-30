import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0

Item {
    property alias mouseArea3: mouseArea4
    property alias mouseArea2: mouseArea2
    property alias mouseArea1: mouseArea1
    property alias loadEventButton: loadEventButton
    property alias saveEventButton: saveEventButton
    property alias loadFilename: loadFilename
    property alias rectangle1: rectangle1
    property alias colourLabel1: colourLabel1
    //property alias openFileDialog1: openFileDialog1
    property alias newEventBut: newEventBut
    property alias downloadBut: downloadBut
    property alias uploadBut: uploadBut
    property alias downloadKey: downloadKey
    property alias firebaseUrlTB: firebaseUrlTB
    property alias firbaseUrlBut: firbaseUrlBut
    Flickable {
        Pane {
            id: eventNamePane
            width: parent.width
            GridLayout {
                width: parent.width;
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right

                GroupBox {
                    width: parent.width
                    title: qsTr("Data file")
                    ColumnLayout {
                        x: -12
                        y: 12
                        RowLayout {
                            TextField {
                                id: loadFilename
                                text: settingsData.dataFilename
                                onEditingFinished: settingsData.dataFilename = text;
                            }
                            /*Button {
                                id: openFileDialog1
                                text: "..."
                                Connections {
                                    onPressed: loadFileDialog.open()
                                }
                            }*/
                            FileDialog {
                                id: loadFileDialog
                                fileMode: FileDialog.OpenFile
                                selectedNameFilter.index: 0
                                nameFilters: ["Json files (*.json)", "Json binary (*.dat )" ]
                                folder: eaContainer.workingDirectory
                                //onAccepted: settingsData.dataFilename = file
                                Connections {
                                    onAccepted: eaContainer.loadEventApp(loadFileDialog.file);
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
                        RowLayout {
                            height: implicitHeight
                            Button {
                                id: loadEventButton
                                text: "Load"
                                Connections {
                                    onPressed: loadFileDialog.open()
                                }
                            }
                            Button {
                                id: saveEventButton
                                text: "Save"
                                Connections {
                                    onPressed: saveFileDialog.open()
                                }
                            }

                            Button {
                                id: newEventBut
                                text: qsTr("New event")
                            }
                        }

                        RowLayout {
                            id: rowLayout1
                            width: 100
                            height: 100

                            TextField {
                                id: downloadKey
                                //text: qsTr("Text Field")
                                text: settingsData.databaseKey
                                onEditingFinished: settingsData.databaseKey = text;
                            }

                            Text {
                                id: text1
                                text: qsTr("Dodwnload Key")
                                font.pixelSize: 12
                            }
                        }

                        RowLayout {
                            id: rowLayout2
                            width: 100
                            height: 100

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

                            ColumnLayout {
                                id: columnLayout1
                                width: 300
                                height: 100

                                Button {
                                    id: firbaseUrlBut
                                    text: qsTr("New firebase url")
                                }

                                TextField {
                                    id: firebaseUrlTB
                                    width: 300; height: 30
                                    //placeholderText: qsTr("Enter firebase url")
                                    //  qsTr("")
                                    //onEditingFinished: eaContainer.firebaseUrl = text;
                                    text: settingsData.firebaseUrl
                                    onEditingFinished: settingsData.firebaseUrl = text;
                                }

                                //Text {
                                //    id: text2
                                //    text: qsTr("Firebase url")
                                //    font.pixelSize: 12
                               // }
                            }
                        } //RowLayout
                    } //ColumnLayout
                } //GroupBox

                GroupBox {
                    title: qsTr("Event app colours");
                    ColumnLayout {
                        RowLayout {
                            spacing: parent.spacing
                            height: colourLabel1.implicitHeight * 2.0
                            Rectangle {
                                id: rectangle1
                                height: parent.height
                                width: height * 2
                                border.color: "black"
                                MouseArea {
                                    id: mouseArea1
                                    anchors.fill: parent
                                }
                            }
                            Label {
                                id: colourLabel1
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        } // RowLayout
                        RowLayout {
                            spacing: parent.spacing
                            height: colourLable2.implicitHeight * 2.0
                            Rectangle {
                                color: eaContainer.eaConstruction.foreColour
                                height: parent.height
                                width: height * 2
                                border.color: "black"
                                MouseArea {
                                    id: mouseArea2
                                    anchors.fill: parent
                                }
                            }
                            Label {
                                id: colourLable2
                                text: qsTr("Foreground colour");
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        } // RowLayout
                        RowLayout {
                            spacing: parent.spacing
                            height: colourLabel2.implicitHeight * 2.0
                            Rectangle {
                                color: eaContainer.eaConstruction.fontColour
                                height: parent.height
                                width: height * 2
                                border.color: "black"
                                MouseArea {
                                    id: mouseArea4
                                    anchors.fill: parent
                                }
                            }
                            Label {
                                id: colourLabel2
                                text: qsTr("Font colour");
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        } // RowLayout
                        RowLayout {
                            spacing: parent.spacing
                            height: colourLabel2.implicitHeight * 2.0
                            Rectangle {
                                color: "#FD871C"
                                height: parent.height
                                width: height * 2
                                border.color: "black"
                                MouseArea {
                                    id: mouseArea5
                                    anchors.fill: parent
                                }
                            }
                            Label {
                                id: colourLabel3
                                text: qsTr("Font colour");
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        } // RowLayout

                    } //ColumnLayout
                } // GroupBox


            } // GridLayout
        } // Pane
    } // Flickable
}
