import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    property alias eventDescription: eventDescription
    property alias parentDescription: parentDescription
    property alias eventNamePane: eventNamePane
    property alias textEventName: textEventName
    property alias textOrgName: textOrgName
    property alias textField1: textField1
    Flickable {
        Pane {
            id: eventNamePane
            width: parent.width
            GridLayout {
                width: parent.width;
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                GroupBox {
                    title: qsTr("Event")
                    ColumnLayout {
                        Label { text: qsTr("Event name"); wrapMode: Label.Wrap  }
                        TextField {
                            id: textEventName
                            placeholderText: qsTr("My event name")
                            //text: eventInfo.eventName;
                        }

                        Label { text: qsTr("Event webpage"); wrapMode: Label.Wrap  }
                        TextField { placeholderText: "www..."; width:  parent.width}

                        Label { width: parent.width; text: qsTr("Event description"); wrapMode: Label.Wrap }
                        TextArea {
                            id: eventDescription
                            anchors.horizontalCenter: parent.horizontalCenter
                            placeholderText: qsTr("Event description")
                            //text: eventInfo.eventDescription;
                            wrapMode: TextArea.Wrap
                        }
                    } // ColumnLayout
                } //GroupBox
                GroupBox {
                    title: qsTr("Parent organisation")
                    ColumnLayout {
                        width: parent.width
                        Label { text: qsTr("Parent organisation name"); wrapMode: Label.Wrap  }
                        TextField {
                            id: textOrgName
                            placeholderText: qsTr("Organisers name")
                            //text: eventInfo.organiserName;
                        }
                        Label { text: qsTr("Parent organisation  webpage"); wrapMode: Label.Wrap  }
                        TextField { id: textField1; placeholderText: "www..."}
                        Label { text: qsTr("Parent organisation description"); wrapMode: Label.Wrap }
                        TextArea {
                            id: parentDescription
                            anchors.horizontalCenter: parent.horizontalCenter
                            placeholderText: qsTr("Describe parent organisation");
                            //text: eventInfo.organiserDescription;
                            wrapMode: TextArea.Wrap
                        }
                    } //ColumnLayout
                } //GroupBox
              } // ColumnLayout

        } //Pane

        ScrollBar.vertical: ScrollBar { }

    }


}
