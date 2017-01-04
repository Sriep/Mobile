import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick 2.7
import QtQuick.Controls 2.1

//Item {
   // width: 520; height: 400

    ColumnLayout {
        //width: parent.width; height: parent.height
       // width: 500; height: 400
        spacing: 5
        property alias capitalizationCombo: capitalizationCombo
        property alias weightCombo: weightCombo
        property alias wordSpacingSpin: wordSpacingSpin
        property alias letterSpacingSpin: letterSpacingSpin
        property alias pixelSizeSpin: pixelSizeSpin
        property alias pointSizeSpin: pointSizeSpin
        property alias strikoutBox: strikoutBox
        property alias overlineBox: overlineBox
        property alias underlineBox: underlineBox
        property alias italicBox: italicBox
        property alias boldBox: boldBox
        property alias fontColour: fontColour
        property alias familyBut: familyBut
        property alias fontFamilyDlg: fontFamilyDlg
        RowLayout {
           // width: parent.width//; height: 720
           // width: 500
            Label {
                id: label1
                text: qsTr("Family")
            }

            Button {
                id: familyBut
                contentItem: Label {
                    text: qsTr(fontFamilyDlg.font.family)
                    font.family: fontFamilyDlg.font.family
                    font.bold: boldBox.checked
                    font.italic: italicBox.checked
                    font.underline: underlineBox.checked
                    font.overline: overlineBox.checked
                    font.strikeout: strikoutBox.checked
                    font.pointSize: pointSizeSpin.value
                    font.pixelSize: pixelSizeSpin.value
                    font.letterSpacing: letterSpacingSpin.value
                    font.wordSpacing: wordSpacingSpin.value
                    font.weight: weightCombo.currentIndex
                    font.capitalization: capitalizationCombo.currentIndex
                    color: tempColour
                    verticalAlignment: Text.AlignVCenter
                }

                flat: true
                //Layout.fillWidth: true
                FontDialog {
                    id: fontFamilyDlg
                    Connections {
                        onAccepted:  chageFamily(familyBut, fontFamilyDlg.font.family);
                    }
                }
                Connections {
                    onPressed: fontFamilyDlg.open();
                }
            }

            Label {
                id: label8
                text: qsTr("colour")
            }

            Button {
                id: fontColour
                text: colorDialog.currentColor
                flat: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                background: Rectangle {
                    id: colourButBackgound
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    color: tempColour
                    //color: colorDialog.currentColor
                }
                ColorDialog {
                    id: colorDialog
                    currentColor: tempColour
                    Connections {
                        onAccepted: tempColour = colorDialog.currentColor;
                    }
                }
                Connections {
                    onPressed: colorDialog.open();
                }
            }
        }

        GridLayout {
            columns: 3; rows: 2
            CheckBox {
                id: boldBox
                text: qsTr("Bold")
                onClicked: tempFont.bold = checked
            }

            CheckBox {
                id: italicBox
                text: qsTr("Italic")
                onClicked: tempFont.italic = checked
            }

            CheckBox {
                id: underlineBox
                text: qsTr("Underline")
                onClicked: tempFont.underline = checked
            }

            CheckBox {
                id: overlineBox
                text: qsTr("Overline")
                onClicked: tempFont.overline = checked
            }

            CheckBox {
                id: strikoutBox
                text: qsTr("Strikout")
                onClicked: tempFont.strikeout = checked
            }
        }

        GridLayout {
            columns: 4; rows: 2
            Label {
                id: label2
                text: qsTr("Point size")
            }
            SpinBox {
                id: pointSizeSpin
            }

            Label {
                id: label3
                text: qsTr("Pixel size")
            }

            SpinBox {
                id: pixelSizeSpin
            }

            Label {
                id: label6
                text: qsTr("Letter spacing")
            }

            SpinBox {
                id: letterSpacingSpin
            }

            Label {
                id: label7
                text: qsTr("Word spacing")
            }

            SpinBox {
                id: wordSpacingSpin
            }
        }

        RowLayout {
            //columns: 2; rows:2
            Label {
                id: label4
                text: qsTr("Weight")
            }

            ComboBox {
                id: weightCombo
                model: ListModel { id: weightModel
                    ListElement { weightName: "Thin"; weightValue: 0 }
                    ListElement { weightName: "ExtraLight"; weightValue: 12 }
                    ListElement { weightName: "Light"; weightValue: 25 }
                    ListElement { weightName: "Normal"; weightValue: 50 }
                    ListElement { weightName: "Medium"; weightValue: 57 }
                    ListElement { weightName: "DemiBold"; weightValue: 63 }
                    ListElement { weightName: "Bold"; weightValue: 75 }
                    ListElement { weightName: "ExtraBold"; weightValue: 81 }
                    ListElement { weightName: "Black"; weightValue: 87 }
                }
                textRole: "weightName"
                delegate: ItemDelegate {
                    id: itemDelegate1
                    text: qsTr(weightName)
                    font.weight: weightValue
                }
            }

            Label {
                id: label5
                text: qsTr("Capitalisation")
            }

            ComboBox {
                id: capitalizationCombo
                model: [
                    "MixedCase"
                    ,"AllUppercase"
                    ,"AllLowercase"
                    ,"SmallCaps"
                    ,"Capitalize"
                ]
            }
        }
        DialogButtonBox {
            standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
            Connections {
                onAccepted: fullFontDlg.oked()
            }

            Connections {
                onRejected: fullFontDlg.cancelled()
            }
        }
    }

//} //Item
