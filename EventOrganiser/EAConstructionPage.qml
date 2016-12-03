import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Window 2.0
import EventAppData 1.0

EAConstructionPageForm {
   /* FileDialog {
        id: fileDialog1
        title: qsTr("Choose data file for avent app")
        nameFilters: [ "Json files (*.json *.dat)" ]
        }
        folder: eaContainer.dataFilename
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            eaContainer.dataFilename = fileDialog.fileUrl;
        }
        onRejected: {
            console.log("Canceled")
        }
    }*/
    loadFilename.text: settingsData.dataFilename// eaContainer.dataFilename
    rectangle1.color: eaContainer.eaConstruction.backColour
    colourLabel1.text: qsTr("Background colour: ")
                       + eaContainer.eaConstruction.backColour;
    /*
    ColorDialog {
        id: colorDialog1
        modality: Qt.WindowModal
        property int index: 0
    }
    colorDialog1.onAccepted: {
        console.log("You chose: " + colorDialog.color)
        switch (index) {
        case 0:
            eaContainer.eaConstruction.backColour = colorDialog.color;
            break;
        case 1:
            eaContainer.eaConstruction.foreColour = colorDialog.color;
            break;
        case 2:
            eaContainer.eaConstruction.fontColour = colorDialog.color;
            break;
        }
    }
    colorDialog1.onRejected: {
        console.log("Canceled")
    }*/
    openFileDialog1.onClicked: fileDialog.open();
    loadEventButton.onClicked: eaContainer.loadEventApp(loadFilename.text);
    saveEventButton.onClicked: eaContainer.saveEventApp(loadFilename.text);
    mouseArea1.onClicked:  {
        colorDialog.index = 0;
        colorDialog.title = qsTr("Select background colour for app");
        colorDialog.color = eaContainer.eaConstruction.backColour;
        colorDialog.open()
    }
    mouseArea2.onClicked:  {
        colorDialog.index = 1;
        colorDialog.title = qsTr("Select foregroud colour for app");
        colorDialog.color = eaContainer.eaConstruction.foreColour;
        colorDialog.open()
        eaContainer.eaConstruction.foreColour = colorDialog.color;
    }/*
    MouseArea3.onClicked:  {
        colorDialog.index = 2;
        colorDialog.title = qsTr("Select font colour for app");
        colorDialog.color = eaContainer.eaConstruction.fontColour;
        colorDialog.open()
        eaContainer.eaConstruction.fontColour = colorDialog.color;
    }*/
}























