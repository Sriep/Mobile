import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4

Item {
    property alias loadCsvBut: loadCsvBut
    property alias titlesList: titlesList
    property alias titlesModel: titlesModel
    property alias dataList: dataList
    property alias dataModel: dataModel
    property alias checkList: checkList
    property alias formatList: formatList
    property alias saveTitlesBut: saveTitlesBut

    width: 900
    Row {
        id: columnLayout1
        spacing: 10

        Button {
            id: loadCsvBut
            text: qsTr("Load ")
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

            ListView {
                id: dataList
                width: parent.width
                height: parent.height
                model: ListModel {
                    id: dataModel
                }
                delegate: DataListDelegate {
                }
            }
        }
    }

}
