import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "dataList.js" as DataListJS

DLImageDelegateForm {
//DataListDelegateForm {
  id: imageDelegate
  property int test: 76

  topText.text: {
      return title;
  }

  bottomText.text: {
      return displayText;
  }
  property url showUrlUrl: "http://lllconf.co.uk/"
  transitions: Transition {
        // Make the state changes smooth
        ParallelAnimation {
            ColorAnimation { property: "color"; duration: 500 }
            NumberAnimation { duration: 300; properties: "detailsOpacity,x,contentY,height,width" }
        }
  }

  maDataDelegate.onClicked: {
      dataListImage.currentIndex = index;
      imageDelegate.state = imageDelegate.state == 'Details' ? "" : "Details";
      console.log("maDataDelegate index",index);
  }

  photoImage.width: eaLVItemList.showPhotos ? 50 : 0

  function popQuestionList (item) { // model=questionsModel
      console.log("Start popItemList");
      questionsModel.clear();
      var questionCount = item.questions.length;
      for ( var i=0 ; i<questionCount ; i++ )
      {
          var eaQuestion = item.questions[i];
          var dic = {
              "questionType" : eaQuestion.itemType
              , "question" : eaQuestion.question
          };
          questionsModel.append(dic);
      }
  }

}
