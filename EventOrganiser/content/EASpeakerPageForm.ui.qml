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
                    delegate: TextField {
                        height: 30
                        placeholderText: delegate
                    }
                }

                ListView {
                    id: checkList
                    width: 80
                    height: 400
                    model: titlesModel
                    delegate: CheckBox {
                        height: 30
                        text: qsTr("In list")
                        checked: inListView
                    }
                }
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
