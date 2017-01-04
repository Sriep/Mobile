import QtQuick 2.7
import QtQuick.Controls 2.0
//import QtQuick.Controls.Material 2.0
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
    var style = settingsData.style;
    reloadEventApp()
  }

  function reloadEventApp() {
    console.log("In reloadEventApp");
    eaContainer.loadEventApp(false);
    console.log("event name: ", eaInfo.eventName);
  }

  function installNewEvent(fileName) {
      console.log("Inn loadNewEventApp", fileName);
      //eaContainer.clearEvent();
      //eaContainer.dataFilename = fileName;
      eaContainer.loadNewEventApp(fileName, true);
  }
  
  Component.onDestruction: {
    settingsData.dataFilename = dataFilename;
    settingsData.style = style;
  }
}
