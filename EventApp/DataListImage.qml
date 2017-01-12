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
    property bool isExpanded: false
    property alias dataModel: dataModel

    onEaLVItemListChanged: {
        console.log("dataListImage eaItemList chnaged");
        resetDataImageListModel(dataModel
                           , eaLVItemList.listName
                           , eaLVItemList.items)
    }

    model: ListModel { id: dataModel }

    delegate:    DLImageDelegate { id: thisDataDelgate
        onStateChanged: {
            dataListImage.isExpanded = state === "Details";
            console.log("DLImageDelegate", index);
            popQuestionList(eaLVItemList.items[index]);
            popMapInfo(eaLVItemList.items[index].mapInfo);
        }

        Connections {
            target: eaLVItemList.items[index]
            onEaQuestionsChanged: {
                console.log("DLImageDelegate", index);
                popQuestionList(eaLVItemList.items[index]);
            }
        }
        Connections {
            target: dataListImage
            onIsExpandedChanged: {
                if (isExpanded === false ) {
                    //eaLVItemList.items[index].saveAnswers();
                    eaLVItemList.saveAnswers(index);
                }
            }
        }
    }



    function resetDataImageLM() {
        resetDataImageListModel(dataModel
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
                ,"showUrl" : items[i].url
                ,"picture" : picturePath
            }
            console.log("resetDataImageListModel i ", i);
            console.log("resetDataImageListModel dic", dic);
            console.log("Url", dic.showUrl);
            dataModel.append(dic);
        }
    }
}
















