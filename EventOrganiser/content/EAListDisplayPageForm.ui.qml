import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
//import "../../EventAppShared"
import "qrc:///shared"

Item {
    property alias titlesList: titlesList
    property alias titlesModel: titlesModel
    property alias thisDataList: thisDataList
    property alias checkList: checkList
    property alias formatList: formatList
    property alias saveTitlesBut: saveTitlesBut
    property alias usePhotos: usePhotos
    property alias loadPhotosBut: loadPhotosBut
    property alias csvFilename: csvFilename
    property alias loadCsvBut: loadCsvBut

    width: 900
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
                width: 500
                height: 400
                title: qsTr("Title fields")

                RowLayout {
                    x: 0
                    y: 0
                    width: parent.width
                    height: 350
                    ListView {
                        id: titlesList
                        width: 150
                        height: 400
                        model: ListModel {
                            id: titlesModel
                        }
                        delegate: Text {
                            height: 30
                            text: field
                        }
                    }

                    ListView {
                        id: formatList
                        width: 200
                        height: 400
                        model: titlesModel
                        delegate: FormatTextDelegate {
                            id: formatTextDelegate
                        }
                    }

                    ListView {
                        id: checkList
                        width: 80
                        height: 400
                        model: titlesModel
                        delegate: InListCheckDelegate {
                            id: inListCheckDelegate
                        }
                    }
                }

                Button {
                    id: saveTitlesBut
                    x: 0
                    y: 360
                    text: qsTr("Save chanages")
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                }
            }

            GroupBox {
                id: dataBox
                width: 300
                height: 400
                title: qsTr("Data list")

                DataList {
                    id: thisDataList
                }
            }
        }

        GroupBox {
            id: groupBox1
            width: 600; height: 100
            title: qsTr("Format image file name")
            ColumnLayout {
                width: 500; height: 200
                RowLayout {
                    width: 500; height: 100
                    anchors.verticalCenter: parent.verticalCenter
                    CheckBox {
                        width: 20; height: 100
                        text: qsTr("Use pictures")
                        id: usePhotos
                    }
                    TextField {
                        width:550; height: 100
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










































