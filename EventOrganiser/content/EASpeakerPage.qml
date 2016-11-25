import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4

EASpeakerPageForm {

    loadCsvBut.onPressed: {
        eventSpeakers.readCSV("Speakers.csv");

        titlesModel.clear();
        //var strTitles = eventSpeakers.titleFields;
        var titleFields = JSON.parse(eventSpeakers.titleFields);
        for ( var i=0 ; i < titleFields["headerFields"].length ; i++ ) {
            titlesModel.append(titleFields["headerFields"][i]);
        }

        dataModel.clear();
        //var strTitles = eventSpeakers.dataList;
        var dataList = JSON.parse(eventSpeakers.dataList);
        for ( var j=0 ; j < dataList["dataItems"].length ; j++ ) {
            dataModel.append(dataList["dataItems"][j]);
        }

    }
}
