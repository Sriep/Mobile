import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
//import EventAppData 1.0

StackLayout {
  id: stackCtl
  anchors.fill: parent
  property int topDrawerId: 0
  property int loadEventId: 1
  property alias drawerModel: drawerModel
  ListView {
    id: drawerView
    width: 110
    height: 160
    delegate: ListDelegate {
      id: drawerDelegate
      text: title
    }
    model: ListModel {
        id: drawerModel
    }
  }
  DownloadEvent {
      id: downloadEvent
  }

}
