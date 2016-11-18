import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
//import QtQuick.Controls.Material 2.0
//import QtQuick.Controls.Universal 2.0
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import EventAppData 1.0

Flickable {
    Pane {
        FileDialog {
            id: fileDialog
            title: qsTr("Choose data file for avent app")
            folder: eaContainer.dataFilename //shortcuts.home
            nameFilters: [ "Json files (*.json *.dat)" ]
            //selectedNameFilter: "All files (*)"
            onAccepted: {
                console.log("You chose: " + fileDialog.fileUrls)
                eaContainer.dataFilename = fileDialog.fileUrl;
            }
            onRejected: {
                console.log("Canceled")
            }

        }

        ColorDialog {
            id: colorDialog
            modality: Qt.WindowModal
            property int index: 0
            onAccepted: {
                console.log("You chose: " + colorDialog.color)
                switch (index) {
                case 0:
                    eaContainer.eaConstruction.backColour = colorDialog.color;
                    break;
                case 1:
                    eaContainer.eaConstruction.foreColour = colorDialog.color;
                    break;
                case 2:
                    eaContainer.eaConstruction.fontColour = colorDialog.color;
                    break;
                }
            }
            onRejected: {
                console.log("Canceled")
            }
            //Component.onCompleted: visible = true
        }

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
                //Layout.fillWidth: true
                ColumnLayout {
                    RowLayout {
                        TextField {
                            placeholderText: qsTr("filename .json or .dat")
                            text: eaContainer.dataFilename
                        }
                        Button {
                            text: "..."
                            onClicked: fileDialog.open();
                        }
                    }
                    RowLayout {
                        height: implicitHeight
                        Button {
                            text: "Load"
                            onClicked: eaContainer.loadEventApp();
                        }
                        Button {
                            text: "Save"
                            onClicked: eaContainer.saveSaveEventApp();
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
                           color: eaContainer.eaConstruction.backColour
                           height: parent.height
                           width: height * 2
                           border.color: "black"
                           MouseArea {
                               anchors.fill: parent
                               onClicked:  {
                                   colorDialog.index = 0;
                                   colorDialog.title = qsTr("Select background colour for app");
                                   colorDialog.color = eaContainer.eaConstruction.backColour;
                                   colorDialog.open()
                               }
                           }
                       }
                       Label {
                           id: colourLabel1
                           text: qsTr("Background colour: ") + eaContainer.eaConstruction.backColour;
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
                               anchors.fill: parent
                               onClicked:  {
                                   colorDialog.index = 1;
                                   colorDialog.title = qsTr("Select foregroud colour for app");
                                   colorDialog.color = eaContainer.eaConstruction.foreColour;
                                   colorDialog.open()
                                   eaContainer.eaConstruction.foreColour = colorDialog.color;
                               }
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
                               anchors.fill: parent
                               onClicked:  {
                                   colorDialog.index = 2;
                                   colorDialog.title = qsTr("Select font colour for app");
                                   colorDialog.color = eaContainer.eaConstruction.fontColour;
                                   colorDialog.open()
                                   eaContainer.eaConstruction.fontColour = colorDialog.color;
                               }
                           }
                       }
                       Label {
                           id: colourLabel2
                           text: qsTr("Font colour");
                           anchors.verticalCenter: parent.verticalCenter
                       }
                   } // RowLayout

               } //ColumnLayout
            } // GroupBox


        } // GridLayout
    } // Pane
} // Flickable
