import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import "content"
import "qrc:///shared"
import EventAppData 1.0

EASelectListForm {  
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
        var index = listsCreated.indexAt(mouse.x, mouse.y);
        listsCreated.currentIndex = index;
        listType.currentIndex = itemsModel.get(index).listType;
        addNewList.newListName.text = itemsModel.get(index).listName;
        //itemData.text = itemsModel.get(index).picture;
        //textFilename.text = itemsModel.get(index).displayText;
       // urlItem.text = itemsModel.get(index).urlString;
    }

    listsCreated.onCreation: {
        popListsList(eaContainer.eaItemLists);
    }

}

/*
ListView {
    id: listsCreated
    width: 110; height: 160

    highlightFollowsCurrentItem: true
    highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
    focus: true

    model: ListModel {
        id: listsModel
        // Same model as eventAppMainPage.stackCtl.drawerView.drawerModel
    }
    delegate: Text {
        height: 30
        text: title
    }
    MouseArea {
        id: mouseAreaLC
        anchors.fill: parent
    }
}
*/
