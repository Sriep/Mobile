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
      onEventCleared: {
          resetToTopDrawer();
      }
  }
  function resetToTopDrawer () {
      toolBar.titleLabel.text = eaContainer.eaInfo.eventName
      stackCtl.currentIndex = stackCtl.topDrawerId;
  }

  Connections {
      target: eaContainer
      onError: {
          messageDialog.title = title
          messageDialog.text = message
          messageDialog.informativeText = information
          messageDialog.icon = icon
          messageDialog.detailedText = details
          messageDialog.visible = true
      }
  }

  Component.onCompleted: {
    console.log("EventAppPageForm onCompleted");
  }

  function refreshLists (stack, model) {
      model.clear();
      clearStack(stack)
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

          newList.createObject(stack
              , {"eaLVItemList": eaContainer.eaItemLists[i]});

          var iconPath = "image://listIcons_" + eaContainer.imageVersion;
          iconPath += "/" + i;

          model.append({
              "title" : eaContainer.eaItemLists[i].listName,
              "position" : i,
              "icon" : iconPath,
              "showIcon" : eaContainer.eaItemLists[i].showIcon
          });
          console.log("refreshLists mount count", model.count);
      } //for
      console.log("End refreshLists");
      //model.sync();
  }

  function needToRefershLists() {
      refreshLists(stackCtl, stackCtl.drawerModel);
  }

  Connections {
      target: eaContainer
      onEaItemListsChanged: {
            refreshLists(stackCtl, drawerModel)
      }
  }

}




















