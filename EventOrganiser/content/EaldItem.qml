import QtQuick 2.0

EaldItemForm {
    id: ealdItemForm
    //property alias featuredList: eaListDisplayPage.featuredList
    //property var featuredItem: eaListDisplayPage.featuredList.items[eaListDisplayPage.featuredItemIndex];
    property var featuredItem: eaListDisplayPage.featuredList !== undefined
      ? eaListDisplayPage.featuredList.items[eaListDisplayPage.featuredItemIndex]
      : undefined;

    property int listIndex: eaListDisplayPage.featuredItemIndex

    addItem.onPressed: {
        console.log("EaldItemForm addItem listIndex",ealdItemForm.listIndex);
        var item = eaListDisplayPage.featuredList.items[ealdItemForm.listIndex];
        console.log("item title", item.title);
        item.addTextQuestion(itemTitle.text);

       // var index = ldpEventAppPage.stackCtl.currentIndex;
        //var listView = ldpEventAppPage.stackCtl.children[index];
        //var tp = listView.temp;
        //listView.resetQuestionList(item);

        //popQuestionList(item, questionsModel);
    }

    function popQuestionList (item, model) { // model=questionsModel
        console.log("Start popItemList");
        model.clear();
        var questionCount = item.questions.length;
        for ( var i=0 ; i<questionCount ; i++ )
        {
            var eaQuestion = item.questions[i];
            var dic = {
                "questionType" : eaQuestion.itemType
                , "question" : eaQuestion.question
            };
            model.append(dic);
        }
    }

    deleteBut.onPressed: {

    }
}
