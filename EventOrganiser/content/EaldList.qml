import QtQuick 2.6
import EventAppData 1.0

EaldListForm {

    Connections {
        target: eaContainer
        onEventCleared: {
            clearDisplay();
            refreshFields();
        }
    }

    Component.onCompleted: {
        refreshFields();
    }

    Connections {
      target: eaContainer
      onEaItemListsChanged: {
          refreshFields();
      }
    }

    Connections {
      target: eaListDisplayPage
      onFeaturedListChanged: {
          refreshFields();
      }
    }
    function loadCsvFile (filename) {
         console.log("EAListDisplayPageForm about to load", filename);
         if (featuredList.loadCSV(filename)) {
            popItemList(featuredList);
            ldpEventAppPage.needToRefershLists();
         }
    }

    function refreshFields() {
        if (featuredList)
            itemNameTA.text = featuredList.listName;
    }

    function popItemList(eventList) {
        console.log("Start popItemList");
        itemsModel.clear();
        if (eventList) {
            var itemCount = eventList.items.length;
            for ( var i=0 ; i<itemCount ; i++ )
            {
                var eaItem = eventList.items[i];
                /*
                var name = eventList.listName;
                var picturePath =  "image://" + name + "/" +i.toString();
                var dic = {
                    "itemType" : eaItem.itemType
                    , "title" : eaItem.title
                    , "displayText" : eaItem.displayText
                    , "showUrl" : eaItem.url
                    , "urlString" : eaItem.urlString
                    , "picture" : picturePath
                };
                itemsModel.append(dic);*/
                itemsModel.append({"title" : eaItem.title} );
            }
            var v = itmesEntered.count;
        } else
            console.log("popItemList evnetList not defined", eventList);
    }

    addItem.onPressed: {
        eaListDisplayPage.featuredList.formatedList = false;
        //eaContainer.insertEmptyItemList(0, newListName.text);
        var itMap = EAItem.Map
        console.log("ItemType.map", itMap);
        console.log("ListType.MAnual", EAItemList.Manual);
        var c= itemTitle.text;
        var a = imageEditGroup.imageFileTF.text;
        var b = textFilename.text;
        var ii = itemDataType.currentIndex;
        var itemType = itemDataType.currentIndex;
        if (itemDataType.currentIndex == EAItem.Map) {
            var token = "";
            if (mapEditGroup.userMap.checked)
                token = mapEditGroup.accessTokenTF.text;
            eaListDisplayPage.featuredList.insertMapItem(itemsModel.count
                                            , itemTitle.text
                                            , "mapbox"
                                            , token
                                            , mapEditGroup.mapIDTF.text
                                            , mapEditGroup.latitudeTF.text
                                            , mapEditGroup.longitudeTF.text
                                            , mapEditGroup.zoomLevelSB.value
                                            , mapEditGroup.useDevicePosition.checked);
        } else {
            eaListDisplayPage.featuredList.insertListItem(itemsModel.count
                                        , itemDataType.currentIndex
                                        , itemTitle.text
                                        , imageEditGroup.imageFileTF.text
                                        , textFilename.text
                                        , urlItem.text);
        }
        var index = ldpEventAppPage.stackCtl.currentIndex;
        var listView = ldpEventAppPage.stackCtl.children[index];
        var tp = listView.temp;
        listView.resetDataImageLM();
        popItemList(eaListDisplayPage.featuredList);
    }

    clearBut.onPressed: {
        clearDisplay();
    }
    function clearDisplay() {
        itmesEntered.currentIndex = -1;
        itemDataType.currentIndex = -1;
        itemTitle.text = "";
        imageEditGroup.imageFileTF.text = "";
        textFilename.text = "";
        urlItem.text = "";
        popItemList(eaListDisplayPage.featuredList);
    }

    mouseAreaLV.onClicked: {
        popItemList(eaListDisplayPage.featuredList);
        var index = itmesEntered.indexAt(mouse.x, mouse.y);
        if (index >= 0)
        {
            itmesEntered.currentIndex = index;
        }
    }

    deleteItemBut.onPressed: {
        var index = itmesEntered.currentIndex;
        eaListDisplayPage.featuredList.deleteItem(index);
        listView.resetDataImageLM();
        popItemList(eaListDisplayPage.featuredList);
        itmesEntered.currentIndex = index-1;
    }

    upItemBut.onPressed: {
        var v = itmesEntered.count;
        var index = itmesEntered.currentIndex;
        var newIndex = eaListDisplayPage.featuredList.moveItem(index, true);
        listView.resetDataImageLM();
        popItemList(eaListDisplayPage.featuredList);
        itmesEntered.currentIndex = newIndex;
    }

    downItemBut.onPressed: {
        var index = itmesEntered.currentIndex;
        var newIndex = eaListDisplayPage.featuredList.moveItem(index, false);
        listView.resetDataImageLM();
        popItemList(eaListDisplayPage.featuredList);
        itmesEntered.currentIndex = newIndex;
    }

}











































