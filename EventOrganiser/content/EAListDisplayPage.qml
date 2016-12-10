import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qrc:///shared/dataList.js" as DataListJS
import EventAppData 1.0

EAListDisplayPageForm {
    id: eaListDisplayPage
   // property EAItemList featuredList: eventSpeakers
    //featuredList: eaListDisplayPage.featuredList
    //property EAItemList featuredList: eaContainer.eaItemLists[0];
    property var featuredList: eaContainer.eaItemLists[0];

    Connections {
        target: ldpEventAppPage.stackCtl
        Component.onCompleted: {
            console.log("ldpEventAppPagone onCompleted count", dpEventAppPage.stackCtl.count);
            console.log("ldpEventAppPagone onCompleted index", dpEventAppPage.stackCtl.currentIndex);
            currentIndex: 2;
        }
    }

    Connections {
        target: ldpEventAppPage.stackCtl
        onCurrentIndexChanged: {
            console.log("EAListDisplayPageForm stack index"
                        , ldpEventAppPage.stackCtl.currentIndex);
            var newIndex = ldpEventAppPage.stackCtl.currentIndex-2;
            if (newIndex>=0)
            {
                console.log("new listName"
                            , eaContainer.eaItemLists[newIndex].listName)
                eaListDisplayPage.featuredList = eaContainer.eaItemLists[newIndex];
                thisFormatedListPanel.popTitlesList(eaListDisplayPage.featuredList);
                thisItemList.popItemList(eaListDisplayPage.featuredList);
                console.log("current listName"
                            , eaListDisplayPage.featuredList.listName)
            }
        }
    }

    listTypeCombo.objectName: {
        eaListDisplayPage.featuredList.formatedList
                = listTypeCombo.currentIndex === 0;
    }

    //listTypeCombo.onFocusChanged: {
    //    console.log("listTypeCombo focus changed")
   // }
}













































