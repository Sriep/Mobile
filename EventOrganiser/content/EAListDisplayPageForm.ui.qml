import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qrc:///shared"

Item {
    property alias titlesList: titlesList
    property alias titlesModel: titlesModel
    //property alias thisDataList: thisDataList
    //property alias checkList: checkList
    //property alias formatList: formatList
    property alias saveTitlesBut: saveTitlesBut
    property alias usePhotos: usePhotos
    property alias loadPhotosBut: loadPhotosBut
    property alias csvFilename: csvFilename
    property alias loadCsvBut: loadCsvBut

    width: 900
    property alias ldpEventAppPage: ldpEventAppPage
    property alias bottomTextArea: bottomTextArea
    property alias topTextArea: topTextArea
    property alias imageFilenameFormat: imageFilenameFormat
    Column {
        id: layout1
        spacing: 10
        RowLayout {
            id: columnLayout1
            width: 200; height: 100
            Button {
                width: parent.width ; height: 100
                id: loadCsvBut
                text: qsTr("Load csv file")
                enabled: csvFilename !== ""
            }
            TextField {
                width: parent.width; height: 100
                id: csvFilename
                placeholderText: qsTr("Enter csv filename")
                text: qsTr("")
            }
        }

        Row {

            GroupBox {
                id: fieldsBox
                width: 500; height: 700
                title: qsTr("Title fields")
                Column {
                    id: column1
                    anchors.fill: parent
                    width: parent.width; height: parent.height
                    RowLayout {
                        //anchors.fill: parent
                        width: parent.width; height: 200
                        anchors.top: parent.top
                        anchors.topMargin: 0
                        /*
                        ListView {
                            id: formatList
                            width: 200; height: parent.height
                            model: titlesModel
                            delegate: FormatTextDelegate {
                                id: formatTextDelegate
                            }
                        }

                        ListView {
                            id: checkList
                            width: 80; height: parent.height
                            model: titlesModel
                            delegate: InListCheckDelegate {
                                id: inListCheckDelegate
                            }
                        }
                        */
                        Rectangle {
                            width: 200;  height: 200
                            border.width : 0.5
                            border.color : "black"
                            ListView {
                                id: titlesList
                                width: 150;  height: 200
                                model: ListModel {
                                    id: titlesModel
                                }
                                delegate: Text {
                                    height: 30
                                    text: field
                                }
                            }
                        }
                        Rectangle {
                            width: 200; height: parent.height
                            border.width : 0.5
                            border.color : "black"
                            TextArea {
                                width: parent.width - 150; height: parent.height
                                id: topTextArea
                                text: qsTr("Text Area")
                                //anchors.left: parent.right
                                anchors.rightMargin: 0
                                //anchors.bottom: bottomTextArea.top

                            }
                        }




                    }
                    Rectangle {
                        width: 300; height: 400
                        border.width : 0.5
                        border.color : "black"
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        anchors.bottom: saveTitlesBut.top
                        TextArea {
                            width: parent.width; height: 250
                            id: bottomTextArea
                            text: qsTr("Text Area")
                        }
                    }
                    Button {
                        height: 30
                        id: saveTitlesBut
                        text: qsTr("Save chanages")
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        anchors.bottom: parent.bottom
                    }
                }

            }

            GroupBox {
                id: dataBox
                width: 500; height: 700
                //width: 300; height: 400
                title: qsTr("Data list")
                clip: true
                EventAppPage {
                    id: ldpEventAppPage
                }
                //DataList {
                //    id: thisDataList
                //}
            }
        }

        GroupBox {
            id: groupBox1
            width: fieldsBox.width; height: 100
            title: qsTr("Format image file name")
            ColumnLayout {
                anchors.fill: parent
                RowLayout {
                    width: parent.width; height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    CheckBox {
                        width: 20; height: 100
                        text: qsTr("Use pictures")
                        id: usePhotos
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
                    height: 100
                    id: loadPhotosBut
                    text: qsTr("Load photos")
                    enabled: imageFilenameFormat !== ""
                }
            }

        }

    }
}










































