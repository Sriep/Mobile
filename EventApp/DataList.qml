import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import EventAppData 1.0
import "qrc:///shared/dataList.js" as DataListJS
/*
DataListForm {
    property EAItemList eaItemList: undefined
    function eaItemListChanged (eaItemList, dataModel) {
        console.log("dataList eaItemList chnaged");
        DataListJS.resetDataListModel(dataModel,
                                      eaItemList.listName
                                   , JSON.parse(eaItemList.dataList));
    }
}
*/
//Item {
    ListView {
        id: dataList
        property EAItemList eaLVItemList: undefined
        onEaLVItemListChanged: {
            console.log("dataList eaItemList chnaged");
            DataListJS.resetDataListModel(dataModel
                                       , eaLVItemList.listName
                                       , JSON.parse(eaLVItemList.dataList))
        }

        property  alias dataModel: dataModel
        model: ListModel {
            id: dataModel
        }
        delegate: DataListDelegate {
        }
    }
//}
