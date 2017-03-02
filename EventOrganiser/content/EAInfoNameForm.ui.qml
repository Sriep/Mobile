import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0
import Qt.labs.settings 1.0


Item {

    property alias textEventName: textEventName
    property alias saveInfo: saveInfo
    property alias newEventButIF: newEventButIF
    property alias urlTF: urlTF
    property alias downloadUrlBtn: downloadUrlBtn
    property alias loadEventButton: loadEventButton
    property alias saveEventButton: saveEventButton
    property alias evnetIconSelect: evnetIconSelect
    property alias iconImage: iconImage
    property alias loadIcon: loadIcon
    property alias cleraIconBut: cleraIconBut
    ColumnLayout {
     //   Flickable {
        width: parent.width
        GroupBox {
            title: qsTr("Event")
            RowLayout {
                width: parent.width;
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
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
                        }
                        //IconSelect {
                        //    id: evnetIconSelect
                        //}
                        RowLayout {
                            id: evnetIconSelect
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
                            Rectangle {
                                id: iconRec
                                width: 40; height: 40
                                border.color: "black"
                                border.width: 1
                                Image {
                                    id: iconImage
                                    visible: eaContainer.showEventIcon
                                    anchors.fill: parent
                                    fillMode: Image.PreserveAspectFit
                                    cache: false
                                    clip: true
                                    MouseArea {
                                        id: iconMA
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

                        Button {
                            id: saveInfo
                            text: qsTr("Save")
                        } //GroupBox
                    } // ColumnLayout
                } //RowLayout
          } // GroupBox

         //   ScrollBar.vertical: ScrollBar { }
         //}
        Button {
            id: newEventButIF
            text: qsTr("New event")
        }
        GroupBox {
            title: qsTr("Load event")
            ColumnLayout {
                RowLayout {
                    id: rowLayout
                    width: 100
                    height: 100
                    Label {

                        text: qsTr("Download from url")
                    }
                    TextField {
                        id: urlTF
                        placeholderText: "Url"
                        //text: qsTr("Text Field")
                        Layout.fillWidth: true
                        cursorVisible: true
                        selectByMouse: true
                    }
                    Button {
                        id: downloadUrlBtn
                        text: qsTr("Downlaod")
                        Connections {
                            onPressed: eaContainer.downloadFromUrl(urlTF.text);
                        }
                    }
                } //RowLayout
                RowLayout {
                    height: implicitHeight
                    Button {
                        id: loadEventButton
                        text: "Load from file"
                        Connections {
                            onPressed: constructionPage.loadFileDialog.open()
                        }
                    }
                    Button {
                        id: saveEventButton
                        text: "Save to file"
                        Connections {
                            onPressed: constructionPage.saveFileDialog.open()
                        }
                    }
                } //RowLayout
            } //ColumnLayout
        } //GroupBox
    } //ColumnLayout


}
