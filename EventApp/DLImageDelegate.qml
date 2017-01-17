import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import QtLocation 5.6
import QtPositioning 5.6
import "dataList.js" as DataListJS

DLImageDelegateForm {
//DataListDelegateForm {
  id: imageDelegate
  property int test: 76

  //topText.text: {
      //topText.text = title;
     // topText.text = eaLVItemList.items[itemIndex].title;
 // }

 // bottomText.text: {
      //bottomText.text = displayText;
     // bottomText.text = eaLVItemList.items[itemIndex].displayText
 // }

  //largePhotoImage.source: {
  //    console.log("largePhoto", "image://" + name + "/" + itemIndex.toString());
  //    largePhotoImage.source =  "image://" + name + "/" + itemIndex.toString();
  //}

  //property url showUrlUrl: "http://lllconf.co.uk/"
  
  transitions: Transition {
        // Make the state changes smooth
        ParallelAnimation {
            ColorAnimation { property: "color"; duration: 500 }
            NumberAnimation { duration: 300; properties: "detailsOpacity,x,contentY,height,width" }
        }
  }

  function saveAnswer(text, quIndex) {
      console.log("In saveAnswers text", text);
      console.log("In saveAnswers quIndex", quIndex);
      console.log("In saveAnswers index", index);
      var ea = eaLVItemList;
      var eaIsa = eaLVItemList.items;
      var item = eaLVItemList.items[index];
      var questions = eaLVItemList.items[index].questions;
      questions[quIndex].answer = text;
  }

  maDataDelegate.onClicked: {
      dataListImage.currentIndex = index;
      imageDelegate.state = imageDelegate.state == 'Details' ? "" : "Details";
      console.log("maDataDelegate index",index);
  }

  photoImage.width: eaLVItemList.showPhotos ? 50 : 0

  function popQuestionList (item) {
      console.log("Start popItemList");
      questionsModel.clear();
      var questionCount = item.questions.length;
      for ( var i=0 ; i<questionCount ; i++ )
      {
          var eaQuestion = item.questions[i];
          var dic = {
              "questionType" : eaQuestion.itemType
              , "question" : eaQuestion.question
              , "answer" : eaQuestion.answer
          };
          questionsModel.append(dic);
      }
  }

  closeBut.onPressed: {
      dataListImage.currentIndex = index;
      imageDelegate.state = imageDelegate.state == 'Details' ? "" : "Details";
      console.log("maDataDelegate index",index);
      //console.log("maDataDelegate listView.currentIndex",dataList.currentIndex);
  }

  /*
  mapData.maptype = "mapbox";
  mapData.accessToken = userMap.checked ? accessTokenTF.text : "";
  mapData.mapId = mapIDTF.text;
  mapData.latitude = latitudeTF.text;
  mapData.lonitude = longitudeTF.text;
  mapData.zoomLevel = zoomLevelSB.value;
  mapData.useCurrent = useDevicePosition.checked;
*/

  function popMapInfo(mapInfo) {
      if (undefined !== mapInfo && null !== mapInfo) {
          setMapPlugin(map, mapInfo.accessToken, mapInfo.mapId);
          //setMapPlugin(map
          //             , "pk.eyJ1Ijoic3JpZXAiLCJhIjoiY2l2aWgxb21oMDA2eDJ6cGZzMHBrYmozdCJ9.qiqUQDSmGbN9Yy0856efSQ"
          //             ,"examples.map-zr0njcqy");
      }
  }

  function setMapPlugin (map, token, mapId) {
      var qmlString = "import QtQuick 2.7\n"
              + "import QtLocation 5.6\n"
              + "import QtPositioning 5.6\n"
              +"Plugin {\n"
              + "\tname: \"mapbox\"\n"
              + "\tPluginParameter {\n"
              + "\t\tname: \"mapbox.access_token\"\n";
      qmlString += "\t\tvalue: \"" + token + "\"\n";
      qmlString += "\t}\n"
              + "\tPluginParameter {\n"
              + "\t\tname: \"mapbox.map_id\"\n";
      qmlString += "\t\tvalue: \"" + mapId + "\"\n\t}\n}";
      console.log("Plugin qml", qmlString);
      var newObject = Qt.createQmlObject(
                  qmlString
                 ,imageDelegate
                 ,"dynamicSnippet1");
      map.plugin = newObject;
  }

  PositionSource {
      id: positionSource
      onPositionChanged: {
      }
  }

  function setDisplayParameters() {
      var displayData = eaContainer.eaConstruction.display;
      var rectangle = imageDelegate.itemBackground;
      var itemTextv = imageDelegate.topText;
      rectangle.x = displayData.x
      rectangle.y = displayData.y
      rectangle.color = displayData.colour
      rectangle.border.color = displayData.borderColour
      rectangle.border.width = displayData.borderWidth
      rectangle.radius = displayData.radius

      textBox.font = displayData.font
      textBox.color = displayData.fontColour
      textBox.style = displayData.textStyle
      textBox.styleColor = displayData.styleColour
  }

}


















