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
  //property alias eaInfo: eaInfo
  //property alias eaItemLists: eaItemLists
  //property alias eaConstruction: eaConstruction
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
  }
  
  Component.onDestruction: {
    settingsData.dataFilename = dataFilename;
  }
}
