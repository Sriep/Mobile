import QtQuick 2.0

EaldListForm {
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
                , "picture" : picturePath
            };
            itemsModel.append(dic);
        }
    }

    addItem.onPressed: {
        eaListDisplayPage.featuredList.formatedList = false;
        //eaContainer.insertEmptyItemList(0, newListName.text);
        var c= itemTitle.text;
        var a = itemData.text;
        var b = textFilename.text;
        var ii = itemDataType.currentIndex;
        var itemType = itemDataType.currentIndex;
        eaListDisplayPage.featuredList.insertListItem(itemsModel.count
                                    , itemDataType.currentIndex
                                    , itemTitle.text
                                    , itemData.text
                                    , textFilename.text
                                    , urlItem.text);
        var index = ldpEventAppPage.stackCtl.currentIndex;
        var listView = ldpEventAppPage.stackCtl.children[index];
        var tp = listView.temp;
        listView.resetDataImageLM();

        popItemList(eaListDisplayPage.featuredList);
    }

    switchFormat.onPressed: {
        eaListDisplayPage.featuredList.formatedList = true;
        listItemEntryStack.currentIndex = 1;
    }


