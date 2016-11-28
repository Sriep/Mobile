import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4

Item {
    property alias formatList: formatList
    property alias itemDelegate1: itemDelegate1
    ListView {
      id: formatList
      width: 200
      height: 400
      model: titlesModel
      delegate: TextField {
          id: formatText
          height: 30
          placeholderText: format

      }

      ItemDelegate {
          id: itemDelegate1
          text: qsTr("Item Delegate")
      }
    }
}
