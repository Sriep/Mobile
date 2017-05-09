import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import EventAppData 1.0

EAInfoThemeForm {
    button1.onClicked: eventContainer.saveSaveEventApp();
    button2.onClicked: eventContainer.loadEventApp();
    //textField1.text: eventContainer.dataFilename;
}
