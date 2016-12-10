import QtQuick 2.0

EaldListForm {

    function popItemList (eventList) {
        console.log("Start popItemList");
        itemsModel.clear();
        var itemCount = eventList.items.length;
        for ( var i=0 ; i<itemCount ; i++ )
        {
            var eaItem = eventList.items.at(i);
            var dic = {
                "itemType" : eaItem.itemType
                , "title" : eaItem.title
                , "data" : eaItem.data
            };
            itemsModel.append(dic);
        }
    }

    addItem.onPressed: {
        eaListDisplayPage.featuredList.formatedList = false;
        //eaContainer.insertEmptyItemList(0, newListName.text);
        var itemType = itemDataType.currentIndex;
        eaListDisplayPage.featuredList.insertListItem(itemsModel.count
                                    , itemDataType.currentIndex
                                    , itemTitle.text
                                    , itemData.text);
        popItemList(eaListDisplayPage.featuredList);
    }

}
