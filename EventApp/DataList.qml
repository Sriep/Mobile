import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import EventAppData 1.0
import "qrc:///shared/dataList.js" as DataListJS

ListView {
    id: dataList

    property EAItemList eaLVItemList: undefined
    property int temp: 54

    onEaLVItemListChanged: {
        console.log("DataList eaItemList chnaged");
        resetDataListModel(dataModel
                           , eaLVItemList.listName
                           , JSON.parse(eaLVItemList.dataList))
    }

    //property  alias dataModel: dataModel
    model: ListModel { id: dataModel }
    delegate: DataListDelegate { }

    function resetDataListModel(dataModel, name, dataList) {
        dataModel.clear();
        for ( var j=0 ; j < dataList["dataItems"].length ; j++ ) {
            var whatis = dataList["dataItems"][j];
            dataModel.append(dataList["dataItems"][j]);
            var picturePath =  "image://" + name + "/" +j.toString();
            dataModel.setProperty(j, "picture", picturePath);
            var newData = dataModel.get(j);
        }
    }
}

