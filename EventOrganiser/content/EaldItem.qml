import QtQuick 2.7
import EventAppData 1.0

EaldItemForm {
    id: ealdItemForm
    //property alias featuredList: eaListDisplayPage.featuredList
    //property var featuredItem: eaListDisplayPage.featuredList.items[eaListDisplayPage.featuredItemIndex];
    property var featuredItem: eaListDisplayPage.featuredList !== undefined
      ? eaListDisplayPage.featuredList.items[eaListDisplayPage.featuredItemIndex]
      : undefined;

    property int listIndex: eaListDisplayPage.featuredItemIndex

    Connections {
        target: eaContainer
        onEventCleared: {
            console.log("EaldItemForm onEventCleared");
        }
    }

    Connections {
        onFeaturedItemChanged: {
            popQuestionList (featuredItem, questionsListModel);
            popMapInfo();
        }
    }

    Component.onCompleted: {
        popQuestionList (featuredItem, questionsListModel);
        popMapInfo();
    }

    addItem.onPressed: {
        console.log("EaldItemForm addItem listIndex",ealdItemForm.listIndex);
        var item = eaListDisplayPage.featuredList.items[ealdItemForm.listIndex];
        console.log("item title", item.title);
        item.addTextQuestion(itemTitle.text);
    }

    function popQuestionList (item, model) { // model=questionsModel
        console.log("Start popQuestionList");
        model.clear();
        var questionCount = item.questions.length;
        for ( var i=0 ; i<questionCount ; i++ )
        {
            var eaQuestion = item.questions[i];
            var dic = {
               // "questionType" : eaQuestion.itemType ,
                 "question" : eaQuestion.question
            };
            model.append(dic);
        }
    }

    function popMapInfo() {
        var meg = mapEditGroup;
        var fi = featuredItem;
        if (featuredItem.mapInfo) {
            mapEditGroup.accessTokenTF.text = featuredItem.mapInfo.accessToken;
            mapEditGroup.mapIDTF.text = featuredItem.mapInfo.mapId;
            mapEditGroup.userMap.checked = featuredItem.mapInfo.accessToken !== "";
            mapEditGroup.latitudeTF.text = featuredItem.mapInfo.latitude;
            mapEditGroup.longitudeTF.text = featuredItem.mapInfo.longitude;
            mapEditGroup.zoomLevelSB.value = featuredItem.mapInfo.zoomLevel;
            mapEditGroup.useDevicePosition.checked = featuredItem.mapInfo.useCurrent;
        }
    }

    updateItem.onPressed: {
        if (listIndex >= 0 && itemDataType.currentIndex >= 0) {
            if (itemDataType.currentIndex == EAItem.Map) {
                var token = "";
                if (mapEditGroup.userMap.checked)
                    token = mapEditGroup.accessTokenTF.text;
                eaListDisplayPage.featuredList.updateMapItem(
                            listIndex
                             , itemTitle.text
                             , "mapbox"
                             , token
                             , mapEditGroup.mapIDTF.text
                             , mapEditGroup.latitudeTF.text
                             , mapEditGroup.longitudeTF.text
                             , mapEditGroup.zoomLevelSB.value
                             , mapEditGroup.useDevicePosition.checked
                            );
                //populateMapData(eaListDisplayPage.featuredList.mapInfo);
                popMapInfo();
            } else {
                eaListDisplayPage.featuredList.updateListItem(
                            listIndex
                          , itemDataType.currentIndex
                          , itemTitle.text
                          , imageIEditGroup.imageFileTF.text
                          , textFilename.text
                          , urlItem.text);
                //popItemList(eaListDisplayPage.featuredList);
            }
        }
    }

    deleteBut.onPressed: {
        eaListDisplayPage.featuredList.deleteItem(listIndex);
        ldpEventAppPage.stackCtl.currentIndex = ldpEventAppPage.stackCtl.topDrawerId;
        //popItemList(eaListDisplayPage.featuredList);
    }

    quMouseAreaLV.onClicked: {
        popQuestionList(featuredItem, questionsListModel);
        var index = questionsList.indexAt(mouse.x, mouse.y);
        if (index >= 0) {
            questionsList.currentIndex = index;
        }       
    }

    deleteQuestionBut.onPressed: {
        var index = questionsList.currentIndex;
       featuredItem.deleteQuestion(index);
       popQuestionList (featuredItem, questionsListModel);
       questionsList.currentIndex = index-1;
    }

    upQuestionBut.onPressed: {
        var v = questionsList.count;
        var index = questionsList.currentIndex;
        var newIndex = featuredItem.moveQuestion(index, true);
        popQuestionList (featuredItem, questionsListModel);
        questionsList.currentIndex = newIndex;
    }

    downQuestionBut.onPressed: {
        var index = questionsList.currentIndex;
        var index = questionsList.currentIndex;
        var newIndex = featuredItem.moveQuestion(index, false);
        popQuestionList (featuredItem, questionsListModel);
        questionsList.currentIndex = newIndex;
    }
}
