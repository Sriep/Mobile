import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import "qrc:///shared"

EventAppPageForm{
  function clearStack(stack) {
    console.log("stack count: ", stack.count);
    var dummy = Qt.createQmlObject(
        "import QtQuick 2.0; Rectangle {id: dummyCtl; }"
       , parent
       , "dummy"
    );

    for ( var index = stack.count-1 ; index > 1 ; index-- ) {
      var child = stack.children[index];
      child.parent = dummy;
      console.log("stack count: ", stack.count);
    }
    dummy.destroy();
  }

  function refreshLists (stack, model) {
      model.clear();
      clearStack(stack)
      var countItemLists = eaContainer.eaItemLists.length;
      for (var i = 0; i < countItemLists; i++) {
          var newList = Qt.createComponent("qrc:///shared/DataList.qml", stack);
          newList.createObject(stack
              , {"eaItemList": eaContainer.eaItemLists[i]});
          model.append({
              "title" : eaContainer.eaItemLists[i].listName,
              "position" : i
          });
      } //for
  }
}

