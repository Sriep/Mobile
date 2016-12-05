import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0

Item {
    property alias mouseArea3: mouseArea4
    property alias mouseArea2: mouseArea2
    property alias mouseArea1: mouseArea1
    property alias loadEventButton: loadEventButton
    property alias saveEventButton: saveEventButton
    property alias loadFilename: loadFilename
    property alias rectangle1: rectangle1
    property alias colourLabel1: colourLabel1
    property alias openFileDialog1: openFileDialog1
    property alias newEventBut: newEventBut
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
                        RowLayout {
                            TextField {
                                id: loadFilename
                            }
                            Button {
                                id: openFileDialog1
                                text: "..."                                                            }
                        }
                        RowLayout {
                            height: implicitHeight
                            Button {
                                id: loadEventButton
                                text: "Load"

                            }
                            Button {
                                id: saveEventButton
                                text: "Save"
                            }

                            Button {
                                id: newEventBut
                                text: qsTr("New event")
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
