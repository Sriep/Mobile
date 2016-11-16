import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Rectangle {
  //color: 'teal'
  //implicitWidth: 200
  //implicitHeight: 200
  width: Math.max(page.viewport.width, grid.implicitWidth + 2 * grid.rowSpacing)
  height: Math.max(page.viewport.height, grid.implicitHeight + 2 * grid.columnSpacing)

  GridLayout {

      anchors.top: parent.top
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.leftMargin: grid.rowSpacing
      anchors.rightMargin: grid.rowSpacing
      anchors.topMargin: grid.columnSpacing
      columns: page.width < page.height ? 1 : 2

      ColumnLayout
      {
          GroupBox {
              title: qsTr("Data file")
              Layout.fillWidth: true
              anchors.fill: parent
              //Label { text: qsTr("Data file"); wrapMode: Label.Wrap  }
              TextField { placeholderText: "?.json"}
          } //GroupBox

          RowLayout
          {
              GroupBox {
                  title: qsTr("Event")
                  Layout.fillWidth: true
                  ColumnLayout {
                      anchors.fill: parent
                      Label { text: qsTr("Event name"); wrapMode: Label.Wrap  }
                      TextField { placeholderText: eventInfo.eventName; width: parent.width}
                      Label { text: qsTr("Event webpage"); wrapMode: Label.Wrap  }
                      TextField { placeholderText: "www..."}
                      Label { text: qsTr("Event description"); wrapMode: Label.Wrap }
                      TextArea { placeholderText: eventInfo.eventDescription; wrapMode: TextArea.Wrap }
                  }
              }
              GroupBox {
                  title: qsTr("Parent organisation")
                  Layout.fillWidth: true
                  ColumnLayout {
                      anchors.fill: parent
                      Label { text: qsTr("Parent organisation name"); wrapMode: Label.Wrap  }
                      TextField { placeholderText: eventInfo.organiserName}
                      Label { text: qsTr("Parent organisation  webpage"); wrapMode: Label.Wrap  }
                      TextField { placeholderText: "www..."}
                      Label { text: qsTr("Parent organisation description"); wrapMode: Label.Wrap }
                      TextArea { placeholderText: eventInfo.organiserDescription; wrapMode: TextArea.Wrap }
                  } //ColumnLayout
              } //GroupBox
          } //RowLayout
      } //ColumnLayout

    } // GridLayout
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
