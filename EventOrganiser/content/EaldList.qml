import QtQuick 2.6
import EventAppData 1.0

EaldListForm {

    Component.onCompleted: {
        console.log("EaldListForm completed");
        console.log("listName", featuredList.listName);
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
 /*
    Connections {
      target: updateTitleBut
      onPressed: {
          featuredList.listName = itemNameTA.text;
      }
    }
*/
    function refreshFields() {
        console.log("listName", featuredList.listName);
        itemNameTA.text = featuredList.listName;
    }

    function popItemList (eventList) {
        console.log("Start popItemList");
        itemsModel.clear();
        var itemCount = eventList.items.length;
        for ( var i=0 ; i<itemCount ; i++ )
        {
            var eaItem = eventList.items[i];//.at(i);
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
            itemsModel.append(dic);
        }
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
        //listView.resetDataListModel();
        //ldpEventAppPage.needToRefershLists("qrc:///shared/DataList.qml");
        popItemList(eaListDisplayPage.featuredList);
    }
/*
    function populateMapData (mapData) {
        //var a0 = eaListDisplayPage.featuredList;
        // var a2 = eaListDisplayPage.featuredList.items[newIndex];
        // var a1 = eaListDisplayPage.featuredList.items;
        //if (itemDataType.currentIndex == EAItem.Map)
        //    populateMapData(eaListDisplayPage.featuredList.items);
        mapData.maptype = "mapbox";
        mapData.accessToken = userMap.checked ? accessTokenTF.text : "";
        mapData.mapId = mapIDTF.text;
        mapData.latitude = latitudeTF.text;
        mapData.lonitude = longitudeTF.text;
        mapData.zoomLevel = zoomLevelSB.value;
        mapData.useCurrent = useDevicePosition.checked;
    }
*/

    clearBut.onPressed: {
        itmesEntered.currentIndex = -1;
        itemDataType.currentIndex = -1;
        itemTitle.text = "";
       // loadImage.file = "";
        imageEditGroup.imageFileTF.text = "";
        textFilename.text = "";
        urlItem.text = "";
    }

    mouseAreaLV.onClicked: {
        var index = itmesEntered.indexAt(mouse.x, mouse.y);
        if (index >= 0)
        {
            itmesEntered.currentIndex = index;
            itemDataType.currentIndex = itemsModel.get(index).itemType;
            itemTitle.text = itemsModel.get(index).title;

            //itemData.text = itemsModel.get(index).picture;
            imageEditGroup.imageFileTF.text = itemsModel.get(index).picture;

            textFilename.text = itemsModel.get(index).displayText;
            urlItem.text = itemsModel.get(index).urlString;
        }
    }
}
