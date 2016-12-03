import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
//import "../../EventAppShared"
import "qrc:/shared"

Item {
    property alias titlesList: titlesList
    property alias titlesModel: titlesModel
    property alias thisDataList: thisDataList
    property alias checkList: checkList
    property alias formatList: formatList
    property alias saveTitlesBut: saveTitlesBut

    width: 900
    property alias csvFilename: csvFilename
    property alias loadCsvBut: loadCsvBut

    Row {
        id: columnLayout1
        spacing: 10

        Button {
            id: loadCsvBut
            text: qsTr("Load csv file")
            enabled: csvFilename !== ""
        }

        TextField {
            id: csvFilename
            placeholderText: qsTr("Enter csv filename")
            text: qsTr("")
        }
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

}
