import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qrc:///shared"

EaldFormatedListForm {
    //id: ealdFormatedList
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
        //DataListJS.resetDataListModel(thisDataList.dataModel
        //     , JSON.parse(eventList.dataList));
        //thisDataList.eaItemList = eventList;
    }

    function saveTitles(eventList) {
        var count = titlesModel.count;
        for ( var i=0 ; i<count ; i++ )
        {
            var titleObj = titlesModel.get(i);
            eventList.amendField(i
                                     ,titleObj.field
                                     , titleObj.modelName
                                     , titleObj.format
                                     , titleObj.inListView);
        }
        eventList.shortFormat = topTextArea.text;
        eventList.longFormat = bottomTextArea.text;
        eventList.saveTitleChanges();
    }

    loadCsvBut.onPressed: {
        console.log("EAListDisplayPageForm about to load", csvFilename.text);
         if (featuredList.readCSV(csvFilename.text)) {
            popTitlesList(featuredList);
            ldpEventAppPage.needToRefershLists();
        }
    }

    saveTitlesBut.onPressed: {
        saveTitles(featuredList)
    }

    loadPhotosBut.onClicked: {
        console.log("In loadPotos");
        console.log("format loadPotos", format);
        featuredList.showPhotos = usePhotos.checked
        var format = imageFilenameFormat.text;
        featuredList.loadPhotos(format);
    }

    topTextArea.text: {
        //console.log("topTextArea.text:: ");
        return featuredList.shortFormat;
        //console.log("topTextArea: ", text );
    }
    bottomTextArea.text: {
        return featuredList.longFormat;
    }

    //usePhotos.checked: featuredList.showPhotos
    //usePhotos.onCheckedChanged: featuredList.showPhotos = usePhotos.checked
  
}
