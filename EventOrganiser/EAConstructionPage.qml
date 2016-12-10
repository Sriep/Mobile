import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Window 2.0
import EventAppData 1.0

EAConstructionPageForm {
    loadFilename.text: settingsData.dataFilename// eaContainer.dataFilename
    rectangle1.color: eaContainer.eaConstruction.backColour
    colourLabel1.text: qsTr("Background colour: ")
                       + eaContainer.eaConstruction.backColour;

    openFileDialog1.onClicked: fileDialog.open();
    loadEventButton.onClicked: eaContainer.loadEventApp(loadFilename.text);
    saveEventButton.onClicked: eaContainer.saveEventApp(loadFilename.text);
    newEventBut.onClicked: eaContainer.clearEvent();

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
    }
}























