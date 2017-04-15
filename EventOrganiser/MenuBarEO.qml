import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import Qt.labs.settings 1.0
import Qt.labs.platform 1.0
import "content"
import "qrc:/shared"
import EventAppData 1.0

MenuBar {
  id: menuBarEO
  property alias fileMenu: fileMenu
  property alias dispalyMenu: dispalyMenu
  property alias helpMenu: helpMenu
  FileDialog {
      id: loadDisplayDialog2
      fileMode: FileDialog.OpenFile
      selectedNameFilter.index: 0
      nameFilters: ["Json files (*.json)" ]
      folder: eaContainer.workingDirectory
      Connections {
          onAccepted: eaContainer.loadDisplayFormat(loadDisplayDialog2.file);
      }
  }
  FileDialog {
      id: saveDispalyDialog2
      fileMode: FileDialog.SaveFile
      selectedNameFilter.index: 0
      nameFilters: ["Json files (*.json)" ]
      folder: eaContainer.workingDirectory
      Connections {
          onAccepted: eaContainer.saveDisplayFormat(saveDispalyDialog2.file);
      }
  }


  Menu {
        id: fileMenu
        title: qsTr("&Event")
        MenuItem {
          text: qsTr("&New")
          onTriggered: eaContainer.clearEvent();
        }
        MenuItem {
          text: qsTr("&Load")
          onTriggered: constructionPage.loadFileDialog.open()
        }
        MenuItem {
          text: qsTr("&Downlaod from url")
          onTriggered: dlgDownloadEventUrl.open()
        }
        MenuItem {
          text: qsTr("&Save As...")
          onTriggered: constructionPage.saveFileDialog.open()
        }
        MenuItem {
          text: qsTr("&Refresh")
          onTriggered: eaContainer.refreshData()
        }
        MenuItem {
          text: qsTr("&Quit")
          onTriggered: Qt.quit()
        }
  }
  Menu {
        id: dispalyMenu
        title: qsTr("&Display")
        MenuItem {
          text: qsTr("&Load display")
          onTriggered: loadDisplayDialog2.open()
        }
        MenuItem {
          text: qsTr("&Save display As...")
          onTriggered: saveDispalyDialog2.open()
        }
  }
  Menu {
        id: helpMenu
        title: qsTr("&Help")
        MenuItem {
          text: qsTr("&Assistant")
          onTriggered: eaAssistant.startAssistant();
        }
        MenuItem {
          text: qsTr("&About")
          onTriggered: aboutDialogEO.open()
        }
  }
}
