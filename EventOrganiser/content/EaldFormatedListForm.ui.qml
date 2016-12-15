import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qrc:///shared"

Item {
    property alias csvFilename: csvFilename
    property alias titlesList: titlesList
    property alias topTextArea: topTextArea
    property alias bottomTextArea: bottomTextArea
    property alias saveTitlesBut: saveTitlesBut
    property alias loadPhotosBut: loadPhotosBut
    property alias imageFilenameFormat: imageFilenameFormat
    property alias usePhotos: usePhotos
    property alias titlesModel: titlesModel
    property alias loadCsvBut: loadCsvBut
    property alias switchManual: switchManual
    property alias deleteList: deleteList
    //property alias listTypeCombo: listTypeCombo
    ColumnLayout {
        id: layout1
        spacing: 5
        RowLayout {
            id: columnLayout1
            width: 200; height: 60
            y:5
            Button {
                height: 50
                id: loadCsvBut
                text: qsTr("Load csv file")
                enabled: csvFilename !== ""
            }
            TextField {
                height: 50
                id: csvFilename
                placeholderText: qsTr("Enter csv filename")
            }
        } // RowLayout

        RowLayout {
            id: fieldsBox
            width: 500; height: 700
            ColumnLayout {
                //anchors.fill: parent
                RowLayout {
                    width: 500; height: 150
                    //anchors.top: parent.top
                    Rectangle {
                        width: 200;  height: 150
                        border.width : 0.5; border.color : "black"
                        ListView {
                            id: titlesList
                            width: 150;  height: 150
                            model: ListModel {
                                id: titlesModel
                            }
                            delegate: Text {
                                height: 30
                                text: field
                            }
                        } // ListView
                    } //Rectangle

                    Rectangle {
                        width: 250; height: 150
                        border.width : 0.5
                        border.color : "black"
                        anchors.rightMargin: 0
                        Flickable {
                            anchors.fill: parent
                            TextArea.flickable: TextArea {
                                id: topTextArea
                                text:  qsTr("Text Area")
                                wrapMode: TextArea.Wrap
                            }
                            ScrollBar.vertical: ScrollBar { }
                        } // Flickable
                    } //Rectangle
                } //RowLayout

                Rectangle {
                    width: 450; height: 300
                    border.width : 0.5
                    border.color : "black"
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    //anchors.bottom: saveTitlesBut.top rowLayout1.top??
                    Flickable {
                        anchors.fill: parent
                        TextArea.flickable: TextArea {
                            id: bottomTextArea
                            text:  qsTr("Text Area")
                            wrapMode: TextArea.Wrap
                        }
                        ScrollBar.vertical: ScrollBar { }
                    }
                } //Rectangle

                RowLayout {
                    id: rowLayout1
                    width: 100
                    height: 100

                    Button {
                        height: 30
                        id: saveTitlesBut
                        text: qsTr("Save chanages")
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        //  anchors.bottom: parent.bottom
                    }

                    Button {
                        id: switchManual
                        text: qsTr("Manual")
                    }

                    Button {
                        id: deleteList
                        text: qsTr("Delete")
                    }
                }
            } // ColumnLayout
        } // RowLayout

        GroupBox {
            id: groupBox1
            width: fieldsBox.width; height: 200
            title: qsTr("Format image file name")
            ColumnLayout {
                // width: fieldsBox.width; height: 200
                anchors.fill: parent
                RowLayout {
                    width: parent.width; height: parent.height
                    //Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    //anchors.verticalCenter: parent.verticalCenter
                    CheckBox {
                        width: 20; height: 100
                        text: qsTr("Use pictures")
                        id: usePhotos
                        //checked: eaListDisplayPage.featuredList.showPhotos
                        //onCheckedChanged: featuredList.showPhotos = usePhotos.checked
                    }
                    TextField {
                        width:parent.width-20; height: 100
                        Layout.fillWidth: true
                        id: imageFilenameFormat
                        enabled: usePhotos.checked
                        text: "%1.png"
                    }
                }

                Button {
                    height: 50
                    id: loadPhotosBut
                    text: qsTr("Load photos")
                    //Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                    enabled: imageFilenameFormat !== ""
                }
            } //ColumnLayout
        } // GroupBox
    }
}
