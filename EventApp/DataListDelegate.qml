import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "dataList.js" as DataListJS

DataListDelegateForm {
    id: dataDelegate

    topText.text: setTopText()
    function setTopText() {
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

    Connections {
      target: footerBar.backBut
      onClicked: {
           dataDelegate.state = ""
      }
    }

    //photoImage.width: eaLVItemList.showPhotos ? 50 : 0

    function displayText(titleFields, dataModel, header, eaItemList) {
        DataListJS.addStringFormat();
        var text = "";
        var myArr = DataListJS.fieldsObjToArr(titleFields["headerFields"], dataModel.get(index));
        if (header) {
            var topFormat = eaItemList.shortFormat;
            text = topFormat.format(myArr);
        } else {
            var bottomFormat = eaItemList.longFormat;
            text = bottomFormat.format(myArr);
        }
        return text;
/*
        var topFormat = eaItemList.shortFormat;
        var t1 = topFormat.format(myArr);
        var bottomFormat = eaItemList.longFormat;
        var t2 = bottomFormat.format(myArr);
        text = header ? t1 : t2;
*/
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

    function setDisplayParameters() {
        DataListJS.setBackgroundDisplayParameters(dataDelegate.itemBackground
                                                  , eaContainer.eaConstruction.display
                                                  , dataDelegate)
        DataListJS.setTextBoxDisplayParameters(dataDelegate.topText
                                            , eaContainer.eaConstruction.display)
        bottomText.font = eaContainer.eaConstruction.display.font
        bottomText.color = eaContainer.eaConstruction.display.fontColour
        bottomText.style = eaContainer.eaConstruction.display.textStyle
        bottomText.styleColor = eaContainer.eaConstruction.display.styleColour
        background.height = parent.height - y*2
        var spp = showPhoto;
        if (dataDelegate.state == 'Details') {
           //dataDelegate.photoImage.height = showPhoto ? 130 : 50;
          dataDelegate.photoImage.width = showPhoto ? 130 : 0;
           dataDelegate.photoImage.x = displayData.xImage;
           dataDelegate.photoImage.y = displayData.yImage;
        } else {
            DataListJS.setImageDisplyaParameters(dataDelegate.photoImage
                           , eaContainer.eaConstruction.display)
            if (!showPhoto)
                 dataDelegate.photoImage.width = 0;
        }
    }
}



































