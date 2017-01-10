import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0

Item {
    //property alias colourLabel1: colourLabel1
    //property alias mouseArea1: mouseArea1
    //property alias mouseArea4: mouseArea4
    //property alias rectangle2: rectangle2
    //property alias rectangle3: rectangle3
    //property alias rectangle4: rectangle4
    //property alias rectangle1: rectangle1
    //property alias mouseArea2: mouseArea2
    property alias styleBox: styleBox
    property alias applyBut: applyBut
    property alias loadBut: loadBut
    property alias saveAsBut: saveAsBut

    ColumnLayout {
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
        /*
        GroupBox {
            title: qsTr("Event app colours");
            ColumnLayout {
                Label {
                    id: colourLabel1
                    text: qsTr("Global back colour/")
                }
                Button {
                    id: backColourBut
                    text: backColorDialog.currentColor
                    flat: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
                    background: Rectangle {
                        id: colourButBackgound
                        implicitWidth: 100
                        implicitHeight: 40
                        opacity: enabled ? 1 : 0.3
                        color: eaContainer.eaConstruction.backColour
                    }
                    ColorDialog {
                        id: backColorDialog
                        currentColor: featuredDisplay.colour
                        Connections {
                            onAccepted: eaContainer.eaConstruction.backColour
                                            = backColorDialog.currentColor;
                        }
                    }
                    Connections {
                        onPressed: backColorDialog.open();
                    }
                }

            } //ColumnLayout
        } // GroupBox
*/
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
                id: saveBut
                visible: false
                text: qsTr("Save")
            }

            Button {
                id: saveAsBut
                text: qsTr("Save as")
                Connections {
                    onPressed: saveFileDialog.open()
                }
            }
        }
    }
}
