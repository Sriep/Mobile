import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "dataList.js" as DataListJS

DataListDelegateForm {
    id: dataDelegate

    topText.text: setTopText()
    function setTopText() {
        var one = JSON.parse(eaLVItemList.titleFields);
        var two = dataModel;
        var t = displayText(JSON.parse(eaLVItemList.titleFields)
                                     , dataModel
                                     , true
                                     , eaLVItemList);
        topText.text = t;
    }
    Connections {
        target: eaLVItemList
        onShortFormatChanged: setTopText();
    }

     Component.onCompleted: {
         console.log("dataDelegate completed");
     }

    bottomText.text: setBottomText()
    function setBottomText() {
        var one = JSON.parse(eaLVItemList.titleFields);
        var two = dataModel;
        //return DataListJS.displayText(JSON.parse(eaLVItemList.titleFields)
        var t = displayText(JSON.parse(eaLVItemList.titleFields)
                                     , dataModel
                                     , false
                                     , eaLVItemList);
        bottomText.text = t;
    }
    Connections {
        target: eaLVItemList
        onLongFormatChanged: setBottomText();
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

    closeBut.onPressed: {
        dataList.currentIndex = index;
        dataDelegate.state = dataDelegate.state == 'Details' ? "" : "Details";
        console.log("maDataDelegate index",index);
        console.log("maDataDelegate listView.currentIndex",dataList.currentIndex);
    }

    //photoImage.width: eaLVItemList.showPhotos ? 50 : 0

    function displayText(titleFields, dataModel, header, eaItemList) {
        DataListJS.addStringFormat();
        var text = "";
        var myArr = DataListJS.fieldsObjToArr(titleFields["headerFields"], dataModel.get(index));
        var topFormat = eaItemList.shortFormat;
        var t1 = topFormat.format(myArr);
        var bottomFormat = eaItemList.longFormat;
        var t2 = bottomFormat.format(myArr);
        text = header ? t1 : t2;
        return text;
    }

    function createDelegateBox(parent) {
        console.log("DataListDelegateForm completed")
        var newObject = Qt.createQmlObject(
               "import QtQuick 2.7
                Rectangle {
                    id: background
                    x: 2; y: 2; width: parent.width - x*2; height: parent.height - y*2
                    color: \"ivory\"
                    border.color: \"orange\"
                    radius: 5
                    opacity: 0.0
                }"
               ,parent
               ,"dynamicSnippet1");
        console.log("DataListDelegateForm completed");
    }

    //function setDisplayParameters(displayData, rectangle, textBox) {
    function setDisplayParameters() {
        var displayData = eaContainer.eaConstruction.display;
        var rectangle = dataDelegate.itemBackground;
        var itemTextv = dataDelegate.topText;
        itemBackground.x = displayData.x
        itemBackground.y = displayData.y
        itemBackground.color = displayData.colour
        itemBackground.border.color = displayData.borderColour
        itemBackground.border.width = displayData.borderWidth
        itemBackground.radius = displayData.radius

        topText.font = displayData.font
        topText.color = displayData.fontColour
        topText.style = displayData.textStyle
        topText.styleColor = displayData.styleColour
    }
/*
    Component.onCompleted: {
        createDelegateBox(dataDelegate);
    }

    Component.onCompleted: {
//        console.log("completed dataDelegate");
    }

    Component.onDestruction: {
       // console.log("destroying dataDelegate");
    }
*/

}



































