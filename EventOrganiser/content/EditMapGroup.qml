import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0
import "qrc:///shared"
import EventAppData 1.0
GroupBox {
    property alias latitudeTF: latitudeTF
    property alias longitudeTF: longitudeTF
    property alias useDevicePosition: useDevicePosition
    property alias userMap: userMap
    property alias mapIDTF: mapIDTF
    property alias accessTokenTF: accessTokenTF
    property alias zoomLevelSB: zoomLevelSB
  id: mapEditGroup
  width: parent.width; //height: 300
  title: qsTr("Map details")
  visible: itemDataType.currentIndex === EAItem.Map
  ColumnLayout {
    CheckBox {
      //visible: itemDataType.currentIndex === EAItem.Map
      //visible: itemDataType.currentIndex === 4
      id: userMap
      text: qsTr("Use you own map")
    }
    RowLayout {
      //visible: itemDataType.currentIndex === EAItem.Map
      Label {
        id: label1
        text: qsTr("Access token")
        enabled: userMap.checked
      }
      TextField {
        id: accessTokenTF
        //placeholderText: qsTr("Access token")
        text: "pk.eyJ1Ijoic3JpZXAiLCJhIjoiY2l2aWgxb21oMDA2eDJ6cGZzMHBrYmozdCJ9.qiqUQDSmGbN9Yy0856efSQ"
        enabled: userMap.checked
        selectByMouse: true
      }
    }
    RowLayout {
      //visible: itemDataType.currentIndex === EAItem.Map
      Label {
        id: label2
        text: qsTr("Map id")
      }
      TextField {
        id: mapIDTF
        text: qsTr("examples.map-zr0njcqy")
        selectByMouse: true
      }
    }
    RowLayout {
      //visible: itemDataType.currentIndex === EAItem.Map
      Label {
        text: qsTr("Zoom level");
      }
      
      SpinBox {
        id: zoomLevelSB;
        value: 14
      }
    }
    RowLayout {
      //visible: itemDataType.currentIndex === EAItem.Map
      CheckBox {
        // visible: itemDataType.currentIndex === 4
        id: useDevicePosition
        text: qsTr("Use current location")
      }
    }
    GridLayout {
      //visible: itemDataType.currentIndex === EAItem.Map
      columns: 2
      rows: 2
      TextField {
        id: latitudeTF
        text: qsTr("")
        enabled: !useDevicePosition.checked
        validator: DoubleValidator {bottom: -90; top: 00;}
        selectByMouse: true
      }
      Label {
        text: qsTr("Latitude")
        enabled: !useDevicePosition.checked
      }
      
      TextField {
        id: longitudeTF
        text: qsTr("")
        enabled: !useDevicePosition.checked
        validator: DoubleValidator {bottom: -180; top: 180;}
        selectByMouse: true
      }
      Label {
        text: qsTr("Longitude")
        enabled: !useDevicePosition.checked
      }
    }
  }
}
