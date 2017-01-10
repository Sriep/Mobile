import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Window 2.0
import EventAppData 1.0

EAConstructionPageForm {
    //loadFilename.text: settingsData.dataFilename// eaContainer.dataFilename


    //openFileDialog1.onClicked: fileDialog.open();
    //loadEventButton.onClicked: eaContainer.loadEventApp(loadFilename.text);
    //saveEventButton.onClicked: eaContainer.saveEventApp(loadFilename.text);

    newEventBut.onClicked: eaContainer.clearEvent();

    uploadBut.onClicked: eaContainer.uploadApp(downloadKey.text);
    downloadBut.onClicked: eaContainer.downloadApp(downloadKey.text);
    firbaseUrlBut.onClicked: eaContainer.firbaseUrl = firebaseUrlTB.text;



    Connections {
      target: eaContainer
      onEaItemListsChanged: {
          //loadFilename.text = eaContainer.dataFilename;
          //eventDescription.text = eaContainer.eventDescription;
          //textOrgName.text = eaContainer.organiserName;
          //parentDescription.text = eaContainer.organiserDescription;
      }
    }

    Connections {
        target: linkBut
        onPressed: {
            var toDate = toCalander.selectedDate;
            eaContainer.firbaseUrl = firebaseUrlTB.text;
            eaContainer.linkFirebaseUrl(downloadKey.text, toDate)
        }
    }
}























