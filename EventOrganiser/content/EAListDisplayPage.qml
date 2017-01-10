import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qrc:///shared/dataList.js" as DataListJS
import EventAppData 1.0

EAListDisplayPageForm {
    id: eaListDisplayPage
    property var featuredList: eaContainer.eaItemLists[0];
    property int featuredItemIndex: 0

    //ldpEventAppPage.stackCtl.children[currentIndex].dataList.thisDataDelgate


    Connections {
        target: ldpEventAppPage.stackCtl
        Component.onCompleted: {
            console.log("ldpEventAppPagone onCompleted count", ldpEventAppPage.stackCtl.count);
            console.log("ldpEventAppPagone onCompleted index", ldpEventAppPage.stackCtl.currentIndex);
            currentIndex: 2;
        }
    }

    function setDisplayPage(index)
    {
        if (index>=0)
        {
            console.log("new listName", eaContainer.eaItemLists[index].listName);
            eaListDisplayPage.featuredList = eaContainer.eaItemLists[index];
            if (eaListDisplayPage.featuredList.formatedList) {
                thisFormatedListPanel.popTitlesList(eaListDisplayPage.featuredList);
                //listItemEntryStack.currentIndex = 1;
                dataDisplayTab.currentIndex = 2;
            } else {
                thisItemList.popItemList(eaListDisplayPage.featuredList);
                //listItemEntryStack.currentIndex = 2;
                dataDisplayTab.currentIndex = 3;
            }
            console.log("current listName"
                        , eaListDisplayPage.featuredList.listName);
        }
        else
        {
            //listItemEntryStack.currentIndex = 0;
            dataDisplayTab.currentIndex = 1;
            console.log("add new list");
        }
    }

    Connections {
        target: ldpEventAppPage.stackCtl
        onCurrentIndexChanged: {           
            //var newIndex = ldpEventAppPage.stackCtl.currentIndex-2;//if (newIndex>=0)
            var offset = ldpEventAppPage.stackCtl.startDrawerId;
            var newIndex = ldpEventAppPage.stackCtl.currentIndex-offset;
            setDisplayPage(newIndex);
        }
    }

    Connections {
        target: ldpEventAppPage.stackCtl.children[ldpEventAppPage.stackCtl.currentIndex]
        onIsExpandedChanged: {            
            console.log("In EAListDisplayPageForm onIsExspandedChanged");
            var eventAppIndex = ldpEventAppPage.stackCtl.currentIndex;
            var listCtl = ldpEventAppPage.stackCtl.children[eventAppIndex];
            var isExpanded = listCtl.isExpanded;
            var offset = ldpEventAppPage.stackCtl.startDrawerId;
            var drawerIndex = ldpEventAppPage.stackCtl.currentIndex-offset;
            if (isExpanded && drawerIndex>=0) {
                //listItemEntryStack.currentIndex = 3;
                dataDisplayTab.currentIndex = 4;
                var itemIndex = listCtl.currentIndex;
                var itemList = listCtl.eaLVItemList;
                var fe = featuredList;
                //var ci = eaLVItemList;
                var formated = eaListDisplayPage.featuredList.formatedList;
                if (!eaListDisplayPage.featuredList.formatedList) {
                    var items = featuredList.items;
                    var currentItem = items[itemIndex];
                    featuredItemIndex = itemIndex;
                }
            } else {
                setDisplayPage(drawerIndex);
            }
        }
    }

    Connections {
        target: listItemEntryStack
        onCurrentIndexChanged: {
            if (listItemEntryStack.currentIndex === 1) {
                thisFormatedListPanel.popTitlesList(eaListDisplayPage.featuredList);
            } else  if (listItemEntryStack.currentIndex === 2) {
                thisItemList.popItemList(eaListDisplayPage.featuredList);
            }
        }
    }
/*
    Connections {
        target: dataDisplayTab
        onPressed: {
           //listItemEntryStack.currentIndex = dataDisplayTab.currentIndex;
        }
     }
*/
}













































