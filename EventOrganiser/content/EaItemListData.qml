import QtQuick 2.0

EaItemListDataForm {
    id: editItemEntry
    Connections {
        target: editItemEntryStack
        onCurrentIndexChanged: {
        }
    }

    Connections {
        target: eaListDisplayPage
        onFeaturedListChanged: {
            editItemEntryStack.currentIndex = eaListDisplayPage.featuredList.listType
        }
    }
}
