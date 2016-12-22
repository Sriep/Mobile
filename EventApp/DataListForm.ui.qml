import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import EventAppData 1.0

Item {
    property alias dataList: dataList
    property alias dataDelegate: dataDelegate
    ListView {
        id: dataList
        width: parent ? parent.width : 400
        height: parent ? parent.height : 600
        property EAItemList eaItemList: undefined
        Connections {
          onEaItemListChanged: eaItemListChanged(dataModel)
        }
        property  alias dataModel: dataModel
        model: ListModel { id: dataModel   }
        delegate: DataListDelegate { id: dataDelegate }
    }
}
