import QtQuick 2.7
//import QtQuick.Controls 2.0
import QtQuick.Controls 2.2
//import QtQuick.Dialogs 1.2

Dialog {
    id: aboutDialog
    title:  eaContainer.eaConstruction.strings.mAbout
    contentItem : Item {
        Column {
            id: aboutColumn
            spacing: 20
            width: parent.width
            Text {
                //width: aboutDialog.availableWidth
                width: parent.width
                text:  eaContainer.eaConstruction.strings.aboutText
                wrapMode: Text.WordWrap
                font.pixelSize: 12
            }
            Text {
                //width: aboutDialog.availableWidth
                width: parent.width
                text: qsTr("<html><h2>Easy Event App</h2><br>")
                      + qsTr("Easy event app displayes  custom event and conference information. Design your own free Event App. ")
                      + "<a href=\"http://www.easyeventapps.com\">www.easyeventapps.com</a><br>"
                      + qsTr("Version ") + eaContainer.appVersion() + "</html>\n"
                wrapMode: Text.WordWrap
                font.pixelSize: 12
            }
        }
    }
    standardButtons: Dialog.Ok
}
