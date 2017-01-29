import QtQuick 2.6
import EventAppData 1.0

EaldListForm {

    Component.onCompleted: {
        refreshFields();
    }

    Connections {
      target: eaContainer
      onEaItemListsChanged: {
          console.log("EaldListForm onEaItemListsChanged");
          refreshFields();
          console.log("EaldListForm onEaItemListsChanged");
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
        console.log("End popItemList");
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

    clearBut.onPressed: {
        itmesEntered.currentIndex = -1;
        itemDataType.currentIndex = -1;
        itemTitle.text = "";
       // loadImage.file = "";
        imageEditGroup.imageFileTF.text = "";
        textFilename.text = "";
        urlItem.text = "";
        popItemList(eaListDisplayPage.featuredList);
    }

    mouseAreaLV.onClicked: {
        var index = itmesEntered.indexAt(mouse.x, mouse.y);
        if (index >= 0)
        {
            itmesEntered.currentIndex = index;
 /*
            itemDataType.currentIndex = itemsModel.get(index).itemType;
            itemTitle.text = itemsModel.get(index).title;
            imageEditGroup.imageFileTF.text = itemsModel.get(index).picture;
            textFilename.text = itemsModel.get(index).displayText;
            urlItem.text = itemsModel.get(index).urlString;
*/
        }
        popItemList(eaListDisplayPage.featuredList);
    }

    deleteItemBut.onPressed: {
        var index = itmesEntered.currentIndex;
        eaListDisplayPage.featuredList.deleteItem(index);
        popItemList(eaListDisplayPage.featuredList);
        itmesEntered.currentIndex = index-1;
    }

    upItemBut.onPressed: {
        var v = itmesEntered.count;
        var index = itmesEntered.currentIndex;
        var newIndex = eaListDisplayPage.featuredList.moveItem(index, true);
        popItemList(eaListDisplayPage.featuredList);
        itmesEntered.currentIndex = newIndex;
    }

    downItemBut.onPressed: {
        var index = itmesEntered.currentIndex;
        var newIndex = eaListDisplayPage.featuredList.moveItem(index, false);
        popItemList(eaListDisplayPage.featuredList);
        itmesEntered.currentIndex = newIndex;
    }

}











































