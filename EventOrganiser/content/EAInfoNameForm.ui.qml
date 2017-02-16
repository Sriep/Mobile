import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    id: eventNamePane
    property alias textEventName: textEventName
    property alias saveInfo: saveInfo
    property alias newEventButIF: newEventButIF
    property alias urlTF: urlTF
    property alias downloadUrlBtn: downloadUrlBtn
    property alias loadEventButton: loadEventButton
    property alias saveEventButton: saveEventButton
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
                //GroupBox {
                    //title: qsTr("Event")
                    ColumnLayout {
                        Button {
                            id: newEventButIF
                            text: qsTr("New event")
                        }
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

                        Button {
                            id: saveInfo
                            text: qsTr("Save")
                        } //GroupBox
                    } // ColumnLayout
                } //RowLayout
          } // GroupBox

         //   ScrollBar.vertical: ScrollBar { }
         //}

        GroupBox {
            title: qsTr("Load event")
            ColumnLayout {
                RowLayout {
                    id: rowLayout
                    width: 100
                    height: 100
                    Label {
                        id: label
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
