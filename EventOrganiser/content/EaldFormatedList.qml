import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qrc:///shared"

EaldFormatedListForm {
    Connections {
        target: eaContainer
        onEventCleared: {
            if (eventList)
                popTitlesList(eventList)
            else
                titlesModel.clear();
        }
    }

    function popTitlesList (eventList) {
        console.log("Start popTitlesList");
        var whatis1
        var newHeader
        titlesModel.clear();
        //titlesModel.sync();
        if (eventList) {
            var titleFields = JSON.parse(eventList.titleFields);
            for ( var i=0 ; i < titleFields["headerFields"].length ; i++ ) {
                whatis1 = titleFields["headerFields"][i];
                titlesModel.append(titleFields["headerFields"][i]);
                newHeader = titlesModel.get(i);
            }
            topTextArea.text = eventList.shortFormat;
            bottomTextArea.text = eventList.longFormat;
        }
        //titlesModel.sync();
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

    function loadCsvFileFormatted (filename) {
        console.log("EAListDisplayPageForm about to load", filename);
        featuredList.loadCSV(filename)
        popTitlesList(featuredList);
        ldpEventAppPage.needToRefershLists();
        setTopTextArea();
        setBottomTextArea();
    }        

    saveTitlesBut.onPressed: {
        saveTitles(featuredList)
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
    function setTopTextArea() {
        if (eaListDisplayPage.featuredList !== undefined)
            topTextArea.text = eaListDisplayPage.featuredList.shortFormat;
        else
            topTextArea.text = "";
    }

    bottomTextArea.text: {
        if (eaListDisplayPage.featuredList !== undefined)
            return eaListDisplayPage.featuredList.longFormat;
        else
            return "";
    }    
    function setBottomTextArea() {
        if (eaListDisplayPage.featuredList !== undefined)
            bottomTextArea.text = eaListDisplayPage.featuredList.longFormat;
        else
            bottomTextArea.text = "";
    }

    usePhotos.checked: {
        if (eaListDisplayPage.featuredList !== undefined)
           return eaListDisplayPage.featuredList.showPhotos;
        else
            return false;
    }

}
