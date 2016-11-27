import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4

EASpeakerPageForm {

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
        dataModel.clear();
        var dataList = JSON.parse(eventSpeakers.dataList);
        for ( var j=0 ; j < dataList["dataItems"].length ; j++ ) {
            var whatis = dataList["dataItems"][j];
            dataModel.append(dataList["dataItems"][j]);
            var newData = dataModel.get(j);
            //console.log("dataList",JSON.stringify(newData));
        }
    }
}
