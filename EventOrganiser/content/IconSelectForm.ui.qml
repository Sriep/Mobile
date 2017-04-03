import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0
import Qt.labs.settings 1.0
import "qrc:///shared"

RowLayout {
    id: iconSelect
    property string lableText: qsTr("Icon")
    property string directory: eaContainer.workingDirectory
    //width: 1000
    height: 40
    visible: updateListBut.visible
    Label {
        id: label
        text: lableText// qsTr("Icon")
    }
    FileDialog {
        id: loadIcon
        fileMode: FileDialog.OpenFile
        selectedNameFilter.index: 0
        nameFilters: [ "Image files (*.png *.bmp *.jpg *.jpeg *.pbm *.pgm *.ppm *.xbm *.xpm)"]
        folder: eaContainer.workingDirectory
    }
    Rectangle{
        id: iconRec
        width: 40; height: 40
        border.color: "black"
        border.width: 1
        Image {
            id: iconImage
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            cache: false
            clip: true
            MouseArea {
                //id: iconSelectMA
                anchors.fill: parent
                Connections {
                  onPressed: loadIcon.open()
                }
            }
        }
    }
    Button {
        id: cleraIconBut
        text: qsTr("Clear icon")
    }
}
