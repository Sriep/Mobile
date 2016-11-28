import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4

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
        dataModel.clear();
        var dataList = JSON.parse(eventSpeakers.dataList);
        for ( var j=0 ; j < dataList["dataItems"].length ; j++ ) {
            var whatis = dataList["dataItems"][j];
            dataModel.append(dataList["dataItems"][j]);
            var newData = dataModel.get(j);
        }
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

/*
    itemDelegate1.onReleased: {
        var index = formatList.currentIndex;
        var titleObj = titlesModel.get(index);
        titleObj.format = text;
        var anotherWay = titlesModel.format;
        titlesModel.set(index, titleObj);
    }

   // itemDelegate1.text: titlesModel.format;

    checkDelegare.onPressed: {
        var index = formatList.currentIndex;
        var titleObj = titlesModel.get(index);
        titleObj.inListView = checkState == Qt.Checked;
        titlesModel.set(index, titleObj);
        titlesModel.get(formatList.currentIndex).inListView;
    }
*/
/*
    TextField {
        id: formatText
        height: 30
        placeholderText: format
        onEditingFinished: {
            var index = formatList.currentIndex;
            var titleObj = titlesModel.get(index);
            titleObj.format = text;
            titlesModel.set(index, titleObj);
        }
    }

    CheckBox {
        id: inListCheck
        height: 30
        text: qsTr("In list")
        checked: inListView

        onClicked: {
            var index = formatList.currentIndex;
            var titleObj = titlesModel.get(index);
            titleObj.inListView = checkState == Qt.Checked;
            titlesModel.set(index, titleObj);
            titlesModel.get(formatList.currentIndex).inListView;
        }
    }*/
}



















