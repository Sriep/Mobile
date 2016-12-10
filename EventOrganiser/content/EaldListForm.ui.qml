import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qrc:///shared"

Item {
    property alias itmesEntered: itmesEntered
    property alias itemDataType: itemDataType
    property alias itemTitle: itemTitle
    property alias itemData: itemData
    property alias addItem: addItem
    //property alias updateItem: updateItem
    property alias itemsModel: itemsModel

    ColumnLayout {
        id: columnLayout1
        width: 100
        height: 100

        ListView {
            id: itmesEntered
            width: 110; height: 160
            model: ListModel {
                id: itemsModel
            }
            delegate: Text {
                height: 30
                text: title
            }
        }

        ComboBox {
            id: itemDataType
            currentIndex: 0
            model: [
                qsTr("Image"),
                qsTr("Document"),
                qsTr("External url")
            ]
        }
        TextField {
            id: itemTitle
            text: qsTr("Title")
        }
        TextField {
            id: itemData
            text: qsTr("Data Link")
        }
        Button {
            id: addItem
            text: qsTr("Add new")
        }

        //Button {
        //    id: updateItem
        //   visible: false
        //    text: qsTr("Update")
        //}
    }


}
