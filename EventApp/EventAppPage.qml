import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.2
import "qrc:///shared"

EventAppPageForm {
  id: eventAppMainPage
  property int testV: 23

  function clearStack(stack) {
    console.log("stack count: ", stack.count);
    var dummy = Qt.createQmlObject(
        "import QtQuick 2.0; Rectangle {id: dummyCtl; }"
       , parent
       , "dummy"
    );

    for ( var index = stack.count-1 ; index >= stack.startDrawerId ; index-- ) {
    //for ( var index = stack.count-1 ; index > 1 ; index-- ) {
      var child = stack.children[index];
      child.parent = dummy;
      console.log("stack count: ", stack.count);
    }
    dummy.destroy();
  }

  Connections {
      target: eaContainer
      onError: {
          messageDialog.title = "Error"
          messageDialog.text = message
          messageDialog.informativeText = information
          messageDialog.icon = icon
          messageDialog.detailedText = details
          //messageDialog.detailedText = "height " + eaContainer.screenHeight
          messageDialog.visible = true
      }
  }

  function refreshLists (stack, model) {
      model.clear();
      //clearStack(stack)
      var stackCount = stack.count;
      var countItemLists = eaContainer.eaItemLists.length;
      for (var i = 0; i < countItemLists; i++) {
          var component;
          //if (eaContainer.eaItemLists[i].formatedList)
          if (0 === eaContainer.eaItemLists[i].listType)
              component = "qrc:///shared/DataList.qml";
          else
              component = "qrc:///shared/DataListImage.qml";
          var newList = Qt.createComponent(component, stack);
          if (stackCount < 10) {
              newList.createObject(stack
                  , {"eaLVItemList": eaContainer.eaItemLists[i]});
          } else {
              newList.createObject(null
                  , {"eaLVItemList": eaContainer.eaItemLists[i]});
          }

          model.append({
              "title" : eaContainer.eaItemLists[i].listName,
              "position" : i
          });
          console.log("refreshLists mount count", model.count);
      } //for
      console.log("End refreshLists")
  }

  function needToRefershLists(dataComponet) {
      refreshLists(stackCtl, stackCtl.drawerModel);
  }

  Connections {
      target: eaContainer
      onEaItemListsChanged: {
            console.log("Page onEaItemListsChanged");
            refreshLists(stackCtl, drawerModel)
            console.log("Page onEaItemListsChanged");
      }
  }

}




















