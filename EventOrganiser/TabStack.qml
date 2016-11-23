import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import "content"
import EventAppData 1.0

StackLayout {
  id: tabStack
  currentIndex: headerTabBar.currentIndex
  anchors.fill: parent
  
  EAConstructionPage {
    property alias eaContainer: eaContainer
    property alias eaConstruction: eaContainer.eaConstruction
    property alias dataFilename: eaContainer.dataFilename
  }
  
  EAInfoPage {
    //id: eventInfoPage
    property alias eventContainer: eaContainer
    property alias eventInfo: eaContainer.eaInfo
    property alias dataFilename: eaContainer.dataFilename
  }
  Rectangle {
    color: 'plum'
    implicitWidth: 300
    implicitHeight: 200
  }
  Rectangle {
    color: 'yellow'
    implicitWidth: 200
    implicitHeight: 200
  }
  Rectangle {
    color: 'brown'
    implicitWidth: 200
    implicitHeight: 200
  }
}
