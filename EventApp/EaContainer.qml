import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.0
import Qt.labs.settings 1.0
import EventAppData 1.0
import "qml"

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
    eaContainer.loadNewEventApp();
    console.log("event name: ", eaInfo.eventName);
  }
  //id: stackCtl
  //title: "Schedule"
  //page: "Schedule.qml"
  function loadNewEventApp() {
      eaContainer.loadEventApp();
      var count = eaContainer.eaItemLists.length;
      console.log("count: ", count);
      for (var i = 0; i < count; i++) {
        console.log("name: ", eaContainer.eaItemLists[i].listName);
        eaContainer.eaItemLists[i].parent = stackCtl;
        titlesModel.append(
            { "title" : eaContainer.eaItemLists[i].listName,
              "page"

                )
      }
      console.log("event name: ", eaInfo.eventName);
  }
  
  Component.onDestruction: {
    settingsData.dataFilename = dataFilename;
  }
}
