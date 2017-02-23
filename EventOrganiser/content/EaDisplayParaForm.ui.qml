import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0
import QtQuick.Controls.Styles 1.4

Item {
    property alias groupDispalyPara: groupDispalyPara
    property alias yTF: yTF
    property alias xTF: xTF
    property alias radiusTF: radiusTF
    property alias applyBut: applyBut
    property alias heightTF: heightTF
    property alias fontDlg: fontDlg
    property alias styleColourDlg: styleColourDlg
    property alias button1: button1
    property alias borderWidthSB: borderWidthSB
    //property alias vAlignCombo: vAlignCombo
    //property alias hAlignCombo: hAlignCombo
    property alias dyTextSB: dyTextSB
    property alias dxTextSB: dxTextSB
    property alias styleCombo: styleCombo
    property alias whiteIconsCB: whiteIconsCB
    property alias bkColourBut: bkColourBut
    property alias styleColourBut: styleColourBut
    property alias colourBut: colourBut
    property alias heightImageSB: heightImageSB
    property alias xImageSB: xImageSB
    property alias yImageSB: yImageSB
    property alias widthImageSB: widthImageSB

    GroupBox {
        id: groupDispalyPara
        width: parent.width; //height: parent.height
        title: qsTr("Main drawer display parameters")

        ColumnLayout {
            id: columnLayout1
            width: parent.width; height: parent.height

            GroupBox {
                id: groupBoxText
                width: parent.width; //height: parent.height/3
                title: qsTr("Text")

                ColumnLayout {
                    id: columnLayout3
                    width: 100
                    height: 90

                    RowLayout {
                        Label {
                            id: label8
                            text: qsTr("Font")
                            Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                        }
                        Button {
                            id: button1
                            flat: true
                            Layout.fillWidth: true
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
                    }
                    RowLayout {
                        Label {
                            id: label6
                            text: qsTr("Text back colour")
                            Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                        }

                        Button {
                            id: colourBut
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

                        Label {
                           // visible: false
                            text: qsTr("Highlight back colour")
                            Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                        }

                        Button {
                            id: button
                            //visible: false
                            text: bkHColorDialog.currentColor
                            flat: true
                            Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                            background: Rectangle {
                                implicitWidth: 100
                                implicitHeight: 40
                                opacity: enabled ? 1 : 0.3
                                color: featuredDisplay.highlitedColour
                            }
                            ColorDialog {
                                id: bkHColorDialog
                                currentColor: featuredDisplay.highlitedColour
                                Connections {
                                    onAccepted: featuredDisplay.highlitedColour = bkHColorDialog.currentColor;
                                }
                            }
                            Connections {
                                onPressed: bkHColorDialog.open();
                            }
                        }

                    }

                    RowLayout {
                        id: rowLayout2
                        width: 100
                        height: 90

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
                        id: rowLayout3
                        width: 100
                        height: 90
                        Label {
                            id: label12
                            text: qsTr("x")
                        }
                        SpinBox {
                            id: dxTextSB
                            value: featuredDisplay.xText
                            from: -99;
                        }
                        Label {
                            id: label13
                            text: qsTr("y")
                        }
                        SpinBox {
                            id: dyTextSB
                            from: -99;
                            value: featuredDisplay.yText
                        }
                    }
                    RowLayout {
                        Label {
                            text: qsTr("height")
                        }
                        SpinBox {
                            id: heightImageSB
                            editable: true
                        }
                    }

                    /*
                    RowLayout {
                        id: rowLayout4
                        width: 100
                        height: 90

                        Label {
                            id: label10
                            visible: false
                            text: qsTr("Horizontal")
                        }

                        ComboBox {
                            id: hAlignCombo
                            visible: false
                            model: ListModel {
                                ListElement { alignName: "AlignLeft"; alignmetValue: 1 }
                                ListElement { alignName: "AlignRight"; alignmetValue: 2 }
                                ListElement { alignName: "AlignHCenter"; alignmetValue: 4 }
                                ListElement { alignName: "AlignJustify"; alignmetValue: 8 }
                            }
                            textRole: "alignName"
                        }

                        Label {
                            id: label11
                            visible: false
                            text: qsTr("Vertical")
                        }

                        ComboBox {
                            id: vAlignCombo
                            visible: false
                            model: ListModel {
                                ListElement { alignName: "AlignTop"; alignmetValue: 32 }
                                ListElement { alignName: "AlignBottom"; alignmetValue: 64 }
                                ListElement { alignName: "AlignVCenter"; alignmetValue: 128 }
                            }
                            textRole: "alignName"
                        }
                    }
                    */
                }
            }
            GroupBox {
                id: groupBoxBackgound
                width: parent.width; //height: parent.height/3
                title: qsTr("Backgound")

                ColumnLayout {
                    id: columnLayout2
                    width: 100
                    height: 90

                    RowLayout {
                        Label {
                            id: label7
                            text: qsTr("Back colour")
                            Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                        }

                        Button {
                            id: bkColourBut
                            // text: qsTr(colorDialog.currentColor.name);
                            text: bkColorDialog.currentColor
                            flat: true
                            Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                            background: Rectangle {
                                // id: colourButBackgound
                                implicitWidth: 100
                                implicitHeight: 40
                                opacity: enabled ? 1 : 0.3
                                color: featuredDisplay.backColour
                            }
                            ColorDialog {
                                id: bkColorDialog
                                currentColor: featuredDisplay.backColour
                                Connections {
                                    onAccepted: featuredDisplay.backColour = bkColorDialog.currentColor;
                                }
                            }
                            Connections {
                                onPressed: bkColorDialog.open();
                            }
                        }

                        CheckBox {
                            id: whiteIconsCB
                            checked: featuredDisplay.whiteIcons
                            text: qsTr("Use White Icons")
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
                            from: -99;
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
                            from: -99
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
                        Label {
                            id: labelBorderColour
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
                }
            }

            GroupBox {
                id: goupImage
                width: parent.width;
                title: qsTr("Image")
                ColumnLayout {
                    /*RowLayout {
                        //width: parent.width;
                        //height: 90
                        Label {
                            text: qsTr("height")
                        }
                        SpinBox {
                            id: heightImageSB
                            editable: true
                        }
                    }*/
                    RowLayout {
                        Label {
                            text: qsTr("x")
                        }
                        SpinBox {
                            id: xImageSB
                            from: -99;
                            editable: true
                        }
                        Label {
                            text: qsTr("y")
                        }
                        SpinBox {
                            id: yImageSB
                            from: -99;
                            editable: true
                        }
                    }
                    RowLayout {
                        Label {
                            text: qsTr("width")
                        }
                        SpinBox {
                            id: widthImageSB
                            from: -99;
                            editable: true
                        }
                    }
                }
            }

            RowLayout {
                id: rowLayout1
                width: 100
                height: 90

                Button {
                    id: applyBut
                    text: qsTr("Apply")
                }

            }
        }


    }

}




























