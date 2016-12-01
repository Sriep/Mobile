import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.0
import Qt.labs.settings 1.0
import EventAppData 1.0

EAContainer {
  id: eaContainer       
  eaConstruction: EAConstruction {}
  eaInfo: EAInfo {}
  eaItemLists: []
  Component.onCompleted: {
    dataFilename = settingsData.dataFilename;
    loadNewEventApp()
  }

  function reloadEventApp() {
    console.log("In reloadEventApp");
    eaContainer.loadNewEventApp();
    console.log("event name: ", eaInfo.eventName);
  }

  function loadNewEventApp() {
      console.log("In loadNewEventApp");
      eaContainer.loadEventApp();
      var countItemLists = eaContainer.eaItemLists.length;
      console.log("eaContainer.eaItemLists.length: ", countItemLists);
      console.log("stackCtl.drawerModel.count: ", drawerModel.count);
      for (var i = 0; i < countItemLists; i++) {
        var newList = Qt.createComponent("DataList.qml", stackCtl);
        newList.createObject(stackCtl
                     , {"eaItemList": eaContainer.eaItemLists[i]});
        console.log("stack countrol count: ", stackCtl.count);
        console.log("stack control current index: ", stackCtl.currentIndex);
        console.log("stackCtl.drawerModel.count: ", stackCtl.drawerModel.count);
        console.log("name: ", eaContainer.eaItemLists[i].listName);
        stackCtl.drawerModel.append({
            "title" : eaContainer.eaItemLists[i].listName
        });
        console.log("stackCtl.drawerModel.count: ", stackCtl.drawerModel.count);
        console.log("stack countrol count: ", stackCtl.count);
        console.log("stack control current index: ", stackCtl.currentIndex);
        var next =  stackCtl.drawerModel.get(i);
      }
      console.log("event name: ", eaInfo.eventName);
  }
  
  Component.onDestruction: {
    settingsData.dataFilename = dataFilename;
  }
}
