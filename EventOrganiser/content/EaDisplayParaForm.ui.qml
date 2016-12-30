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
    property alias widthTF: widthTF
    property alias radiusTF: radiusTF
    property alias applyBut: applyBut
    property alias button2: button2
    property alias button3: button3
    property alias button4: button4
    property alias heightTF: heightTF
    property alias styleBox: styleBox

    GroupBox {
        id: groupBox1
        width: parent.width; height: parent.height
        title: qsTr("Main drawer display parameters")

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
                    /*Component.onCompleted: {
                        styleIndex = find(settings.style, Qt.MatchFixedString)
                        if (styleIndex !== -1)
                            currentIndex = styleIndex
                    }*/
                    //Layout.fillWidth: true
                }
            }

            GridLayout {
                id: gridLayout1
                width: parent.width; height: parent.height
                columns: 3
                rows: 8

                Label {
                    id: label1
                    text: qsTr("x")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                TextField {
                    id: xTF
                    Layout.maximumWidth: 35
                    text: featuredDisplay.x
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    KeyNavigation.tab: yTF
                    validator: IntValidator{bottom: 0; top: 50;}
                    Component.onCompleted: text = featuredDisplay.x
                }

                Button {
                    id: xQueryBut
                    width: 8
                    text: qsTr("?")
                    Layout.maximumHeight: 16
                    Layout.maximumWidth: 16
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    checkable: true
                }

                Label {
                    id: label2
                    text: qsTr("y")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                TextField {
                    id: yTF
                    Layout.maximumWidth: 35
                    text: featuredDisplay.y
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    validator: IntValidator{bottom: 0; top: 50;}

                }

                Button {
                    id: yQueryBut
                    Layout.maximumHeight: 16
                    Layout.maximumWidth: 16
                    text: qsTr("?")
                    checkable: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                Label {
                    id: label3
                    text: qsTr("width")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                TextField {
                    id: widthTF
                    Layout.maximumWidth: 50
                    text: featuredDisplay.width
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    validator: IntValidator{bottom: -1; top: 1000}
                }

                Button {
                    id: widthQueryBut
                    Layout.maximumHeight: 16
                    Layout.maximumWidth: 16
                    text: qsTr("?")
                    checkable: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                Label {
                    id: label4
                    text: qsTr("height")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                TextField {
                    id: heightTF
                    Layout.maximumWidth: 50
                    text: featuredDisplay.height
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    validator: IntValidator{bottom: -1; top: 1000}
                }

                Button {
                    id: heigthQueryBut
                    Layout.maximumHeight: 16
                    Layout.maximumWidth: 16
                    text: qsTr("?")
                    checkable: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                Label {
                    id: label5
                    text: qsTr("radius")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                TextField {
                    id: radiusTF
                    Layout.maximumWidth: 50
                    text: featuredDisplay.radius
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    validator: IntValidator{bottom: -360; top: 360;}
                }
                Button {
                    id: readiusQueryBut
                    Layout.maximumHeight: 16
                    Layout.maximumWidth: 16
                    text: qsTr("?")
                    checkable: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                Label {
                    id: label6
                    text: qsTr("back colour")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                Button {
                    id: colourBut
                    text: qsTr("Perss")
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

                Button {
                    id: backColourQueryBut
                    Layout.maximumHeight: 16
                    Layout.maximumWidth: 16
                    text: qsTr("?")
                    checkable: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                Label {
                    id: label7
                    text: qsTr("Border colour")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                Button {
                    text: qsTr("Perss")
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

                Button {
                    id: borderColourQueryBut
                    Layout.maximumHeight: 16
                    Layout.maximumWidth: 16
                    text: qsTr("?")
                    checkable: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                Label {
                    id: label8
                    text: qsTr("Font")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                }

                Button {
                    text: featuredDisplay.font.family
                    flat: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    FontDialog {
                        id: fontDlg
                        font: featuredDisplay.font
                        Connections {
                            onAccepted: featuredDisplay.font = fontDlg.font;
                        }
                    }
                    Connections {
                        onPressed: fontDlg.open();
                    }
                }

                Button {
                    id: fontQueryBut
                    Layout.maximumHeight: 16
                    Layout.maximumWidth: 16
                    text: qsTr("?")
                    checkable: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
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
                    id: button2
                    text: qsTr("Load")
                }

                Button {
                    id: button3
                    text: qsTr("Save")
                }

                Button {
                    id: button4
                    text: qsTr("Save as")
                }
            }
        }
    }

}
