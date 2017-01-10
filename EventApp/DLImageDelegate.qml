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

}


















