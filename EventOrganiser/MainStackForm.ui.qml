import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import "content"


StackLayout {
      id: mainStackCtl
      anchors.fill: parent

      WelcomeTabForm {
      }

      EAConstructionPageForm {
      }

      EAInfoPageForm {
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


