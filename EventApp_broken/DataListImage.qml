import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import EventAppData 1.0
import "qrc:///shared/dataList.js" as DataListJS

// List view for showing items added manually in EvantApp.
// Crated dynamically from EvantAppPage.qml refershLists
ListView {
    id: dataListImage
    property int temp: 32

    property EAItemList eaLVItemList: undefined
    property alias dataImageModel: dataImageModel
    onEaLVItemListChanged: {
        console.log("dataListImage eaItemList chnaged");
        resetDataImageListModel(dataImageModel
                           , eaLVItemList.listName
                           , eaLVItemList.items)
    }

/*
    eventAppMainPage.stackCtl[currentIndex]
    eaLVItemList.onEaItemListChanged: {
        console.log("dataListImage onEaItemListChanged");
        resetDataImageListModel(dataImageModel
                               , eaLVItemList.listName
                               , eaLVItemList.items)
    }
*/

    model: ListModel { id: dataImageModel }
    //delegate: DataListDelegate { }
    delegate: DLImageDelegate { }

    function resetDataImageLM() {
        resetDataImageListModel(dataImageModel
                           , eaLVItemList.listName
                           , eaLVItemList.items);
    }

    function resetDataImageListModel(dataModel, name, items) {
        dataModel.clear();
        console.log("items.length", items.length);
        for ( var i=0 ; i<items.length ; i++ )
        {
            var whatis = items[i];
            var picturePath =  "image://" + name + "/" +i.toString();
            var uu = items[i].url;
            var uuu = items[i].urlString;
            var dic = {
                "itemType" : items[i].itemType
                ,"title" : items[i].title
                ,"displayText" : items[i].displayText
                //,"showUrl" : "http://lllconf.co.uk/"//items[i].url
                ,"showUrl" : items[i].urlString
                ,"picture" : picturePath
            }
            console.log("resetDataImageListModel i ", i);
            console.log("resetDataImageListModel dic", dic);
            dataModel.append(dic);
        }
    }
}
















