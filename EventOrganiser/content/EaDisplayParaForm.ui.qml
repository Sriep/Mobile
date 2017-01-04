import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0
import QtQuick.Controls.Styles 1.4

Item {
    property alias colourBut: colourBut
    property alias colorDialog: colorDialog
    property alias yTF: yTF
    property alias xTF: xTF
    //property alias widthTF: widthTF
    property alias radiusTF: radiusTF
    property alias applyBut: applyBut
    property alias button3: button3
    property alias button4: button4
    property alias heightTF: heightTF
    property alias styleBox: styleBox
    property alias fontDlg: fontDlg
    property alias styleColourBut: styleColourBut
    property alias styleColourDlg: styleColourDlg
    property alias button1: button1
    property alias borderWidthSB: borderWidthSB

    GroupBox {
        id: groupBox1
        width: parent.width; height: parent.height
        title: qsTr("Main drawer display parameters")

        FileDialog {
            id: loadFileDialog
            fileMode: FileDialog.OpenFile
            selectedNameFilter.index: 0
            nameFilters: ["Json files (*.json)" ]
            folder: eaContainer.workingDirectory
            //onAccepted: settingsData.dataFilename = file
            Connections {
                //console.log("loadFileDialog", loadFileDialog.file);
                onAccepted: eaContainer.loadDisplayFormat(loadFileDialog.file);
            }
        }
        FileDialog {
            id: saveFileDialog
            fileMode: FileDialog.SaveFile
            selectedNameFilter.index: 0
            nameFilters: ["Json files (*.json)" ]
            folder: eaContainer.workingDirectory
            //onAccepted: settingsData.dataFilename = file
            Connections {
                //console.log("loadFileDialog", saveFileDialog.file);
                onAccepted: eaContainer.saveDisplayFormat(saveFileDialog.file);
            }
        }

        ColumnLayout {
            id: columnLayout1
            width: 100
            height: 100
            RowLayout {
                Label {
                    id: lableSytleBox
                    text: qsTr("Material style")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }
                ComboBox {
                    id: styleBox
                    property int styleIndex: -1
                    model: ["Default", "Material", "Universal"]
                    Component.onCompleted: setStyleCombo
                }
            }

            RowLayout {
                Label {
                    id: label8
                    text: qsTr("Font")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }
                Button {
                    id: button1
                    flat: true
                    background: Rectangle {
                        color: featuredDisplay.colour
                    }
                    contentItem: Label {
                        text: featuredDisplay.font.family
                        font: featuredDisplay.font
                        color: featuredDisplay.fontColour
                        verticalAlignment: Text.AlignVCenter
                    }
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    //Layout.fillWidth: true
                    FontDlg {
                       id: fontDlg
                    }
                    Connections {
                        onPressed: fontDlg.open();
                    }
                }
           // }

           // RowLayout {
                Label {
                    id: label6
                    text: qsTr("back colour")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }       

                Button {
                    id: colourBut
                   // text: qsTr(colorDialog.currentColor.name);
                    text: colorDialog.currentColor
                    flat: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    background: Rectangle {
                        id: colourButBackgound
                        implicitWidth: 100
                        implicitHeight: 40
                        opacity: enabled ? 1 : 0.3
                        color: featuredDisplay.colour
                    }
                    ColorDialog {
                        id: colorDialog
                        currentColor: featuredDisplay.colour
                        Connections {
                            onAccepted: featuredDisplay.colour = colorDialog.currentColor;
                        }
                    }
                    Connections {
                        onPressed: colorDialog.open();
                    }
                }
            }

            RowLayout {
                Label {
                    id: label7
                    text: qsTr("Border colour")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                Button {
                    text: bdColourDlg.currentColor
                    flat: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 40
                        opacity: enabled ? 1 : 0.3
                        color: featuredDisplay.borderColour
                    }
                    ColorDialog {
                        id: bdColourDlg
                        currentColor: featuredDisplay.borderColour
                        Connections {
                            onAccepted: featuredDisplay.borderColour = bdColourDlg.currentColor;
                        }
                    }
                    Connections {
                        onPressed: bdColourDlg.open();
                    }
                }

                Label {
                    text: qsTr("Border width")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                SpinBox {
                    id: borderWidthSB
                    value: featuredDisplay.borderWidth
                    ToolTip.delay: 1000
                    ToolTip.timeout: 5000
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Border width in pixels.")
                }
            }

            GridLayout {
                id: gridLayout1
                width: parent.width; height: parent.height
                columns: 4
                rows: 8

                Label {
                    id: label1
                    text: qsTr("x")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                SpinBox {
                    id: xTF
                    KeyNavigation.tab: yTF
                    value: featuredDisplay.x
                    ToolTip.delay: 1000
                    ToolTip.timeout: 5000
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Indentation distance in pixels.")
                }

                Label {
                    id: label2
                    text: qsTr("y")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                SpinBox {
                    id: yTF
                    KeyNavigation.tab: yTF
                    value: featuredDisplay.y
                    ToolTip.delay: 1000
                    ToolTip.timeout: 5000
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Gap between drawers.")
                }

                Label {
                    id: label4
                    text: qsTr("height")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                SpinBox {
                    id: heightTF
                    KeyNavigation.tab: yTF
                    value: featuredDisplay.height
                    from: 10; to: 200
                    ToolTip.delay: 1000
                    ToolTip.timeout: 5000
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Height of drawers.")
                }

                Label {
                    id: label5
                    text: qsTr("radius")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                SpinBox {
                    id: radiusTF
                    KeyNavigation.tab: yTF
                    value: featuredDisplay.radius
                    ToolTip.delay: 1000
                    ToolTip.timeout: 5000
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Radious of courner curve.")
                }
            }

            RowLayout {
                id: rowLayout2
                width: 100
                height: 100

                Label {
                    id: label3
                    text: qsTr("Style")
                }

                ComboBox {
                    id: styleCombo
                    model: [
                        "Normal"
                        ,"Outline"
                        ,"Raised"
                        ,"Sunken"
                    ]
                }

                Label {
                    id: label9
                    text: qsTr("Style Colour")
                }

                Button {
                    id: styleColourBut
                    text: styleColourDlg.currentColor
                    flat: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 40
                        opacity: enabled ? 1 : 0.3
                        color: styleColourDlg.currentColor
                    }
                    ColorDialog {
                        id: styleColourDlg
                    }
                    Connections {
                        onPressed: styleColourDlg.open();
                    }
                }
            }
            RowLayout {
                id: rowLayout1
                width: 100
                height: 100

                Button {
                    id: applyBut
                    text: qsTr("Apply")
                }

                Button {
                    id: loadBut
                    text: qsTr("Load")
                    Connections {
                        onPressed: loadFileDialog.open()
                    }
                }

                Button {
                    id: button3
                    text: qsTr("Save")
                }

                Button {
                    id: button4
                    text: qsTr("Save as")
                    Connections {
                        onPressed: saveFileDialog.open()
                    }
                }
            }
        }
    }

}




























