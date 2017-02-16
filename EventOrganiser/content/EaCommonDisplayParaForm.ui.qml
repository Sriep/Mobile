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
    //property alias pumpkin: pumpkin
    property alias styleBox: styleBox
    property alias applyBut: applyBut
    property alias loadBut: loadBut
    property alias saveAsBut: saveAsBut
    property alias mouseAreaLV: mouseAreaLV
    property alias displayList: displayList
    property alias newFormat: newFormat
    property alias displaysModel: displaysModel

    ColumnLayout {
        FileDialog {
            id: loadDisplayDialog
            fileMode: FileDialog.OpenFile
            selectedNameFilter.index: 0
            nameFilters: ["Json files (*.json)" ]
            folder: eaContainer.workingDirectory
            //onAccepted: settingsData.dataFilename = file
            Connections {
                //console.log("loadFileDialog", loadFileDialog.file);
                onAccepted: eaContainer.loadDisplayFormat(loadDisplayDialog.file);
            }
        }
        FileDialog {
            id: saveDispalyDialog
            fileMode: FileDialog.SaveFile
            selectedNameFilter.index: 0
            nameFilters: ["Json files (*.json)" ]
            folder: eaContainer.workingDirectory
            //onAccepted: settingsData.dataFilename = file
            Connections {
                //console.log("loadFileDialog", saveFileDialog.file);
                onAccepted: eaContainer.saveDisplayFormat(saveDispalyDialog.file);
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
                    onPressed: loadDisplayDialog.open()
                }
            }

            Button {
                id: saveAsBut
                text: qsTr("Save as")
                Connections {
                    onPressed: saveDispalyDialog.open()
                }
            }
        }

        GroupBox {
            width: 200; height: 200
            ColumnLayout {
                Rectangle {
                    border.color: "black"
                    border.width: 1
                    width: 200; height: 200
                    clip: true
                    ListView {
                        id: displayList
                        y: 10
                        x: 10
                        //width: 110; height: 160
                        width: parent.width-20; height: parent.height
                        highlightFollowsCurrentItem: true
                        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
                        focus: true
                        model: ListModel {
                            id: displaysModel
                        }
                        delegate: Text {
                            y:10
                            height: 30
                            text: displayName
                        }
                        MouseArea {
                            id: mouseAreaLV
                            anchors.fill: parent
                        }
                        //Component.onCompleted:  popDisplayList;
                    }
                 }
                Button {
                    id: newFormat
                   // visible: false
                    text: qsTr("Apply format")
                }

            }
        }
    }
}
