import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0

TabBar {
  id: headerTabBar
  Layout.minimumWidth: 360
  Layout.minimumHeight: 360
  Layout.preferredWidth: 480
  Layout.preferredHeight: 640

  TabButton {
    text: qsTr("Construction")
  }
  //TabButton {
  //  text: qsTr("Event")
  //}
  TabButton {
    text: qsTr("Data")
  }
  TabButton {
    text: qsTr("Display")
  }
  TabButton {
    text: qsTr("Form answers")
  }
}
