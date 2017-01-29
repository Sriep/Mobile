import QtQuick 2.0

EaldItemForm {
    id: ealdItemForm
    //property alias featuredList: eaListDisplayPage.featuredList
    //property var featuredItem: eaListDisplayPage.featuredList.items[eaListDisplayPage.featuredItemIndex];
    property var featuredItem: eaListDisplayPage.featuredList !== undefined
      ? eaListDisplayPage.featuredList.items[eaListDisplayPage.featuredItemIndex]
      : undefined;

    property int listIndex: eaListDisplayPage.featuredItemIndex

    Component.onCompleted: {
        popQuestionList (featuredItem, questionsListModel);
    }

    addItem.onPressed: {
        console.log("EaldItemForm addItem listIndex",ealdItemForm.listIndex);
        var item = eaListDisplayPage.featuredList.items[ealdItemForm.listIndex];
        console.log("item title", item.title);
        item.addTextQuestion(itemTitle.text);
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

    updateItem.onPressed: {
        if (itmesEntered.currentIndex >= 0 && itemDataType.currentIndex >= 0) {
            eaListDisplayPage.featuredList.updateListItem(itmesEntered.currentIndex
                                              , itemDataType.currentIndex
                                              , itemTitle.text
                                              , imageEditGroup.imageFileTF.text
                                              , textFilename.text
                                              , urlItem.text);
            if (itemDataType.currentIndex == EAItem.Map)
                populateMapData(eaListDisplayPage.featuredList.mapInfo);
            popItemList(eaListDisplayPage.featuredList);
        }
    }

    deleteBut.onPressed: {
        eaListDisplayPage.featuredList.removeItem(itmesEntered.currentIndex);
        ldpEventAppPage.stackCtl.currentIndex = ldpEventAppPage.stackCtl.topDrawerId;
        popItemList(eaListDisplayPage.featuredList);
    }

    quMouseAreaLV.onClicked: {
        var index = itmesEntered.indexAt(mouse.x, mouse.y);
        if (index >= 0) {
            questionsList.currentIndex = index;
        }
        popQuestionList (featuredItem, questionsListModel);
    }
}
