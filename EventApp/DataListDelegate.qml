import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "dataList.js" as DataListJS

DataListDelegateForm {
    id: dataDelegate
    topText.text: { // eaLVItemList for eaItemList
        var one = JSON.parse(eaLVItemList.titleFields);
        var two = dataModel;
        //return DataListJS.displayText(JSON.parse(eaLVItemList.titleFields)
        return displayText(JSON.parse(eaLVItemList.titleFields)
                                     , dataModel
                                     , true
                                     , eaLVItemList);
    }

    bottomText.text: {
        var one = JSON.parse(eaLVItemList.titleFields);
        var two = dataModel;
        //return DataListJS.displayText(JSON.parse(eaLVItemList.titleFields)
        return displayText(JSON.parse(eaLVItemList.titleFields)
                                     , dataModel
                                     , false
                                     , eaLVItemList);
    }

    transitions: Transition {
        // Make the state changes smooth
        ParallelAnimation {
            ColorAnimation { property: "color"; duration: 500 }
            NumberAnimation { duration: 300; properties: "detailsOpacity,x,contentY,height,width" }
        }
    }

    maDataDelegate.onClicked: {
        dataList.currentIndex = index;
        dataDelegate.state = dataDelegate.state == 'Details' ? "" : "Details";
        console.log("maDataDelegate index",index);
        console.log("maDataDelegate listView.currentIndex",dataList.currentIndex);
    }

    photoImage.width: eaLVItemList.showPhotos ? 50 : 0

    function displayText(titleFields, dataModel, header, eaItemList) {
        DataListJS.addStringFormat();
        var text = "";
        for ( var i=0 ; i < titleFields["headerFields"].length ; i++ ) {
            if (titleFields["headerFields"][i].inListView === header)
            {
                var formatStr = titleFields["headerFields"][i].format;
                var title = titleFields["headerFields"][i].field;
                var model = titleFields["headerFields"][i].modelName;
                var myData = dataModel.get(index);
                var reqField = myData[model];
                var formatArr = [];//[title, reqField];
                formatArr.push(title);
                formatArr.push(reqField);
                var item = formatStr.format(formatArr);
                text += item;
            }
        }
        var myArr = DataListJS.fieldsObjToArr(titleFields["headerFields"], dataModel.get(index));
        var topFormat = eaItemList.shortFormat;
        var t1 = topFormat.format(myArr);
        var bottomFormat = eaItemList.longFormat;
        var t2 = bottomFormat.format(myArr);
        text = header ? t1 : t2;
        return text;
    }
/*
    function fieldsObjToArr(titles, dataObj) {
        var formatArr = [];
        for ( var i=0 ; i < titles.length ; i++ )
        {
            var model = titles[i].modelName;
            var reqField = dataObj[model];
            formatArr.push(reqField);
        }
        return formatArr;
    }
*/
}

