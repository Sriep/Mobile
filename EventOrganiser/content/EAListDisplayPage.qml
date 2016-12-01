import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qrc:/shared/dataList.js" as DataListJS

EAListDisplayPageForm {

    loadCsvBut.onPressed: {
        eventSpeakers.readCSV("Speakers.csv");
        titlesModel.clear();
        var whatis1
        var newHeader
        var titleFields = JSON.parse(eventSpeakers.titleFields);
        for ( var i=0 ; i < titleFields["headerFields"].length ; i++ ) {
            whatis1 = titleFields["headerFields"][i];
            titlesModel.append(titleFields["headerFields"][i]);
            newHeader = titlesModel.get(i);
        }
        DataListJS.resetDataListModel(thisDataList.dataModel
             , JSON.parse(eventSpeakers.dataList));
        thisDataList.eaItemList = eventSpeakers;
    }

    saveTitlesBut.onPressed: {
        var count = titlesModel.count;
        for ( var i=0 ; i<count ; i++ )
        {
            var titleObj = titlesModel.get(i);
            eventSpeakers.amendField(i
                                     ,titleObj.field
                                     , titleObj.modelName
                                     , titleObj.format
                                     , titleObj.inListView);
        }
        eventSpeakers.saveTitleChanges();
    }
}



















