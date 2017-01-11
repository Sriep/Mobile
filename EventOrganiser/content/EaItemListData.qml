import QtQuick 2.0

EaItemListDataForm {
    id: editItemEntry
    Connections {
        target: editItemEntryStack
        onCurrentIndexChanged: {
            console.log("new editItemEntryStack.currentIndex"
                    , editItemEntry.editItemEntryStack.currentIndex);
            console.log("featuredList.listType", featuredList.listType);
            console.log("featuredList.listName", featuredList.listName);
        }
    }

    Connections {
        target: eaListDisplayPage
        onFeaturedListChanged: {
            console.log("new featured list", featuredList.listName);
            console.log("new featured list", eaListDisplayPage.featuredList.listType);
            var a = editItemEntryStack;
            editItemEntryStack.currentIndex = eaListDisplayPage.featuredList.listType
            console.log("onFeaturedListChanged.currentIndex"
                    , editItemEntryStack.currentIndex);
        }
    }


}
