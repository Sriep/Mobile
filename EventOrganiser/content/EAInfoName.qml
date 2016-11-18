import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import EventAppData 1.0

Flickable {
    Pane {
        id: eventNamePane
        width: parent.width
        //contentWidth: view.implicitWidth
        //contentHeight: view.implicitHeight
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
                        //width:  Math.max(implicitWidth, Math.min(implicitWidth * 2, eventNamePane.availableWidth / 3))
                        //width: implicitWidth
                        placeholderText: qsTr("My event name")
                        text: eventInfo.eventName;
                    }

                    Label { text: qsTr("Event webpage"); wrapMode: Label.Wrap  }
                    TextField { placeholderText: "www..."; width:  parent.width}

                    Label { width: parent.width; text: qsTr("Event description"); wrapMode: Label.Wrap }
                    TextArea {
                        width: Math.max(implicitWidth, Math.min(implicitWidth * 3, eventNamePane.availableWidth / 3))
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.left: parent.left; anchors.right: parent.right
                        placeholderText: qsTr("Event description")
                        text: eventInfo.eventDescription;
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
                        placeholderText: qsTr("Organisers name")
                        text: eventInfo.organiserName;
                    }
                    Label { text: qsTr("Parent organisation  webpage"); wrapMode: Label.Wrap  }
                    TextField { placeholderText: "www..."}
                    Label { text: qsTr("Parent organisation description"); wrapMode: Label.Wrap }
                    TextArea {
                        width: Math.max(implicitWidth, Math.min(implicitWidth * 3, eventNamePane.availableWidth / 3))
                        anchors.horizontalCenter: parent.horizontalCenter
                        placeholderText: qsTr("Describe parent organisation");
                        text: eventInfo.organiserDescription;
                        wrapMode: TextArea.Wrap
                    }
                } //ColumnLayout
            } //GroupBox
          } // ColumnLayout

    } //Pane

    ScrollBar.vertical: ScrollBar { }

}

/*
      ColumnLayout {
          spacing: 10
          anchors.fill: parent
          width: parent.width/2
          Label {
              width: parent.width
              wrapMode: Label.Wrap
              //horizontalAlignment: Qt.AlignHCenter
              text: qsTr("Parent organisation name")
          }

          TextField {
              placeholderText: "TextField"
              //width: Math.max(implicitWidth, Math.min(implicitWidth * 2, pane.availableWidth / 3))
              anchors.horizontalCenter: parent.horizontalCenter
          }

          Label {
              width: parent.width
              wrapMode: Label.Wrap
              //horizontalAlignment: Qt.AlignHCenter
              text: qsTr("Parent organisation webpage")
          }

          TextField {
              placeholderText: "TextField"
              //width: Math.max(implicitWidth, Math.min(implicitWidth * 2, pane.availableWidth / 3))
              anchors.horizontalCenter: parent.horizontalCenter
          }

          Label {
              width: parent.width
              wrapMode: Label.Wrap
              //horizontalAlignment: Qt.AlignHCenter
              text: qsTr("Parent organisation description.")
          }

          TextArea {
              //width: Math.max(implicitWidth, Math.min(implicitWidth * 3, pane.availableWidth / 3))
              anchors.horizontalCenter: parent.horizontalCenter

              wrapMode: TextArea.Wrap
              text: "TextArea\n...\n...\n..."
          }

    }
  }*/




//"id": 1,
//"name": "Open Tech Summit",
//"description": "The OpenTechSummit brings the exciting ideas and creators of the open-Technology community in Berlin.",
//"organizer_name": "FOSSASIA",
//"organizer_description": "Promoting open source ideas and technology throughout the world",
