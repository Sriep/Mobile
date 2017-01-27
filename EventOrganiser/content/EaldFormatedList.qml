import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qrc:///shared"

EaldFormatedListForm {
    function popTitlesList (eventList) {
        console.log("Start popTitlesList");
        var whatis1
        var newHeader
        titlesModel.clear();
        var titleFields = JSON.parse(eventList.titleFields);
        for ( var i=0 ; i < titleFields["headerFields"].length ; i++ ) {
            whatis1 = titleFields["headerFields"][i];
            titlesModel.append(titleFields["headerFields"][i]);
            newHeader = titlesModel.get(i);
        }
        topTextArea.text = eventList.shortFormat;
        bottomTextArea.text = eventList.longFormat;
    }

    function saveTitles(eventList) {
        var count = titlesModel.count;
        eventList.shortFormat = topTextArea.text;
        eventList.longFormat = bottomTextArea.text;
       /* for ( var i=0 ; i<count ; i++ )
        {
            var titleObj = titlesModel.get(i);
            eventList.amendField(i
                                     ,titleObj.field
                                     , titleObj.modelName
                                     , titleObj.format
                                     , titleObj.inListView);
        }*/
        eventList.saveTitleChanges();
    }

    //loadCsvBut.onPressed: {
    function loadCsvFile (filename) {
         console.log("EAListDisplayPageForm about to load", filename);
         if (featuredList.readCSV(filename)) {
            popTitlesList(featuredList);
            ldpEventAppPage.needToRefershLists("qrc:///shared/DataList.qml");
         }
    }
    //}

    saveTitlesBut.onPressed: {
        saveTitles(featuredList)
    }

    deleteList.onPressed: {
        var offset = ldpEventAppPage.stackCtl.startDrawerId;
        var index = ldpEventAppPage.stackCtl.currentIndex-offset
        if (index >= 0) {
            eaContainer.deleteItemList(index);
            ldpEventAppPage.stackCtl.currentIndex = ldpEventAppPage.stackCtl.topDrawerId;
            dataDisplayTab.currentIndex = 1;
        }
    }

    switchManual.onPressed: {
        if (eaListDisplayPage.featuredList !== undefined)
            eaListDisplayPage.featuredList.formatedList = false;
        //listItemEntryStack.currentIndex = 2;
        dataDisplayTab.currentIndex = 2;
    }

    loadPhotosBut.onClicked: {
        console.log("In loadPotos");
        if (eaListDisplayPage.featuredList !== undefined)   {
            eaListDisplayPage.featuredList.showPhotos = usePhotos.checked;
            var format = imageFilenameFormat.text;
            eaListDisplayPage.featuredList.loadPhotos(format);
        }
    }

    topTextArea.text: {
        if (eaListDisplayPage.featuredList !== undefined)
            return eaListDisplayPage.featuredList.shortFormat;
        else
            return "";
    }

    bottomTextArea.text: {
        if (eaListDisplayPage.featuredList !== undefined)
            return eaListDisplayPage.featuredList.longFormat;
        else
            return "";
    }

    usePhotos.checked: {
        if (eaListDisplayPage.featuredList !== undefined)
           return eaListDisplayPage.featuredList.showPhotos;
        else
            return false;
    }

    //usePhotos.checked: featuredList.showPhotos
    //usePhotos.onCheckedChanged: featuredList.showPhotos = usePhotos.checked
  
}
