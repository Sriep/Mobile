import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0
import "qrc:///shared"
//import EventAppData 1.0
GroupBox {
    property alias imageFileTF: imageFileTF

    id: imageEditGroup
    title: qsTr("Image details")
    //width: parent.width;

    FileDialog {
        id: loadImage
        fileMode: FileDialog.OpenFile
        selectedNameFilter.index: 0
        nameFilters: [ "Image files (*.png *.bmp *.jpg *.jpeg *.pbm *.pgm *.ppm *.xbm *.xpm)"]
        folder: eaContainer.workingDirectory
        //onAccepted: settingsData.dataFilename = file
        Connections {
            onAccepted: imageFileTF.text = loadImage.file;
        }
    }

    RowLayout {
        id: rowLayout2
        //width: parent.width;
        //height: 100

        Button  {
            id: imageFile
            text: qsTr("Load image file")
            Connections {
                onPressed: loadImage.open()
            }
        }

        Label {
            id: imageFileTF
            text: qsTr("")
           // width: parent.width
            //selectByMouse: true
        }
    }
  
}
