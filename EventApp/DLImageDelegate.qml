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

  topText.text: {
      topText.text = title;
  }

  bottomText.text: {
      bottomText.text = displayText;
  }

  property url showUrlUrl: "http://lllconf.co.uk/"

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
  /*mapData.maptype = "mapbox";
  mapData.accessToken = userMap.checked ? accessTokenTF.text : "";
  mapData.mapId = mapIDTF.text;
  mapData.latitude = latitudeTF.text;
  mapData.lonitude = longitudeTF.text;
  mapData.zoomLevel = zoomLevelSB.value;
  mapData.useCurrent = useDevicePosition.checked;*/
    function popMapInfo(mapInfo) {
        if (undefined !== mapInfo) {

            var qmlString = "import QtQuick 2.7
import QtLocation 5.6
import QtPositioning 5.6
Plugin {
      name: \"mapbox\"
      PluginParameter {
         name: \"mapbox.access_token\"\n";
            qmlString += "\tvalue: \"" + mapInfo.accessToken + "\"\n";
            qmlString += " }
  PluginParameter {
      name: \"mapbox.map_id\"\n";
            qmlString += "\tvalue: \"" + mapInfo.mapId + "\"\n}\n}";
/*
            var qmlString = "import QtQuick 2.7
            import QtLocation 5.6
            import QtPositioning 5.6
            Plugin {
                  name: \"mapbox\"
                  PluginParameter {
                     name: \"mapbox.access_token\"
                     value: \"pk.eyJ1Ijoic3JpZXAiLCJhIjoiY2l2aWgxb21oMDA2eDJ6cGZzMHBrYmozdCJ9.qiqUQDSmGbN9Yy0856efSQ\"
                  }
                  PluginParameter {
                      name: \"mapbox.map_id\"
                      value: \"examples.map-zr0njcqy\"
                  }
            }"
*/
            console.log("Plugin qml", qmlString);
            var newObject = Qt.createQmlObject(
                        qmlString
                       ,imageDelegate
                       ,"dynamicSnippet1");
            map.plugin = newObject;
        }
    }

  Plugin {
        name: "mapbox"
        PluginParameter {
           name: "mapbox.access_token"
           value: "pk.eyJ1Ijoic3JpZXAiLCJhIjoiY2l2aWgxb21oMDA2eDJ6cGZzMHBrYmozdCJ9.qiqUQDSmGbN9Yy0856efSQ"
        }
        PluginParameter {
            name: "mapbox.map_id"
            value: "examples.map-zr0njcqy"
            //value: "mapbox.mapbox-streets"
        }
  }


  PositionSource {
      id: positionSource
      onPositionChanged: {
      }
  }

}


















