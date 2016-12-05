import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import EventAppData 1.0
import "qrc:///shared/dataList.js" as DataListJS

ListView {  
    id: dataList
    width: parent ? parent.width : 400
    height: parent ? parent.height : 600
    property EAItemList eaItemList: undefined
    onEaItemListChanged: {
        console.log("dataList eaItemList chnaged");
        DataListJS.resetDataListModel(dataModel
                                   , JSON.parse(eaItemList.dataList))
    }

    property  alias dataModel: dataModel
    model: ListModel {
        id: dataModel
    }
    delegate: DataListDelegate {
    }
}
