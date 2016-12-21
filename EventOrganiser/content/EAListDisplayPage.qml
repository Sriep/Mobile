import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qrc:///shared/dataList.js" as DataListJS
import EventAppData 1.0

EAListDisplayPageForm {
    id: eaListDisplayPage
    property var featuredList: eaContainer.eaItemLists[0];

    Connections {
        target: ldpEventAppPage.stackCtl
        Component.onCompleted: {
            console.log("ldpEventAppPagone onCompleted count", ldpEventAppPage.stackCtl.count);
            console.log("ldpEventAppPagone onCompleted index", ldpEventAppPage.stackCtl.currentIndex);
            currentIndex: 2;
        }
    }

    Connections {
        target: ldpEventAppPage.stackCtl
        onCurrentIndexChanged: {
            console.log("EAListDisplayPageForm stack index"
                        , ldpEventAppPage.stackCtl.currentIndex);//var newIndex = ldpEventAppPage.stackCtl.currentIndex-2;
            var newIndex = ldpEventAppPage.stackCtl.currentIndex-2;//if (newIndex>=0)
            if (newIndex>=0)
            {
                console.log("new listName"
                            , eaContainer.eaItemLists[newIndex].listName);
                eaListDisplayPage.featuredList = eaContainer.eaItemLists[newIndex];
                if (eaListDisplayPage.featuredList.formatedList) {
                    thisFormatedListPanel.popTitlesList(eaListDisplayPage.featuredList);
                    listItemEntryStack.currentIndex = 1;
                } else {
                    thisItemList.popItemList(eaListDisplayPage.featuredList);
                    listItemEntryStack.currentIndex = 2;
                }
                console.log("current listName"
                            , eaListDisplayPage.featuredList.listName);
            }
            else
            {
                listItemEntryStack.currentIndex = 0;
                console.log("add new list");
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

}













































