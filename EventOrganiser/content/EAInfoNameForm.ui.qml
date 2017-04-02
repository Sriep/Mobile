import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0
import Qt.labs.settings 1.0


Item {

    property alias textEventName: textEventName
    property alias saveInfo: saveInfo
    //property alias newEventButIF: newEventButIF
    property alias evnetIconSelect: evnetIconSelect
    property alias iconToolbarImage: iconToolbarImage
    property alias loadToolbarIcon: loadToolbarIcon
    property alias clearToolbarIconBut: clearToolbarIconBut
    ColumnLayout {
        width: parent.width
        GroupBox {
            title: qsTr("Toolbar")
            RowLayout {
                width: parent.width;
                ColumnLayout {
                    RowLayout {
                        Label { text: qsTr("Event name"); wrapMode: Label.Wrap  }
                        TextField {
                            id: textEventName
                            placeholderText: qsTr("My event name")
                            cursorVisible: true
                            selectByMouse: true
                            focus: true
                            //text: eventInfo.eventName;
                        }
                        Button {
                            id: saveInfo
                            text: qsTr("Save")
                        }
                    }
                    RowLayout {
                        id: evnetIconSelect
                        property string lableText: qsTr("Icon")
                        property string directory: eaContainer.workingDirectory
                        //width: 1000
                        height: 40
                       // visible: updateListBut.visible
                        Label {
                            id: label
                            text: lableText// qsTr("Icon")
                        }
                        FileDialog {
                            id: loadToolbarIcon
                            fileMode: FileDialog.OpenFile
                            selectedNameFilter.index: 0
                            nameFilters: [ "Image files (*.png *.bmp *.jpg *.jpeg *.pbm *.pgm *.ppm *.xbm *.xpm)"]
                            folder: eaContainer.workingDirectory
                        }
                        Rectangle {
                            id: iconRec
                            width: 40; height: 40
                            border.color: "black"
                            border.width: 1
                            Image {
                                id: iconToolbarImage
                                visible: eaContainer.showEventIcon
                                anchors.fill: parent
                                fillMode: Image.PreserveAspectFit
                                cache: false
                                clip: true
                                MouseArea {
                                    id: iconToolbarMA
                                    anchors.fill: parent
                                    Connections {
                                        onPressed: loadIcon.open()
                                    }
                                }
                            }
                        }
                        Button {
                            id: clearToolbarIconBut
                            text: qsTr("Clear icon")
                        }
                    }
                 } // ColumnLayout
             } //RowLayout
          } // GroupBox
        /*
        Button {
            id: newEventButIF
            text: qsTr("New event")
        }
        */
    }
}
