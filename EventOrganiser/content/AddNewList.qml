import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import "qrc:///shared"

AddNewListForm {
    addListBut.onClicked: {
        //eaContainer.insertEmptyItemList(0, newListName.text, listType.currentIndex === 0);
        eaContainer.insertEmptyItemList(0, newListName.text, listType.currentIndex);
        popListsList(eaContainer.eaItemLists);
    }

    function popListsList (eaItemLists) {
        listsModel.clear();
        var listCount = eaItemLists.length;
        for ( var i=0 ; i<listCount ; i++ )
        {
            var thisList  = eaItemLists[i];
            var dic = {
                "listType" : eaItemLists[i].listType
                ,"listName" : eaItemLists[i].listName
            }
            listsModel.append(dic);
        }
    }

    mouseAreaLC.onClicked: {
        //if (0 === listsModel.count)
            popListsList(eaContainer.eaItemLists);

        var index = listsCreated.indexAt(mouse.x, mouse.y);
        if (index >= 0) {
            listsCreated.currentIndex = index;
            listType.currentIndex = listsModel.get(index).listType;
            newListName.text = listsModel.get(index).listName;

            updateListBut.visible = true;
            deleteListBut.visible = true;
            newListBut.visible = true;
            addListBut.visible = false;
        } else {
            addListBut.visible = true;
        }
    }

    newListBut.onPressed: {
        newListName.text = "";
        updateListBut.visible = false;
        deleteListBut.visible = false;
        newListBut.visible = false;
        addListBut.visible = true;
        popListsList(eaContainer.eaItemLists);
    }

    updateListBut.onPressed: {
        var index = listsCreated.currentIndex;
        eaContainer.eaItemLists[index].listType = listType.currentIndex;
        eaContainer.eaItemLists[index].listName = newListName.text;
        popListsList(eaContainer.eaItemLists);
    }

    deleteListBut.onPressed: {
        var index = listsCreated.currentIndex;
        eaContainer.deleteItemList(index);
        popListsList(eaContainer.eaItemLists);
    }

    //Component.onCompleted: {
    //     console.log("completed AddNewListForm");
    //     popListsList(eaContainer.eaItemLists);
    //}


    //listsCreated.onCreation: {
    //    popListsList(eaContainer.eaItemLists);
    //}
}
