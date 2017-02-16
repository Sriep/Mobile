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
  FileDialog {
      id: loadDisplayDialog2
      fileMode: FileDialog.OpenFile
      selectedNameFilter.index: 0
      nameFilters: ["Json files (*.json)" ]
      folder: eaContainer.workingDirectory
      //onAccepted: settingsData.dataFilename = file
      Connections {
          //console.log("loadFileDialog", loadFileDialog.file);
          onAccepted: eaContainer.loadDisplayFormat(loadDisplayDialog2.file);
      }
  }
  FileDialog {
      id: saveDispalyDialog2
      fileMode: FileDialog.SaveFile
      selectedNameFilter.index: 0
      nameFilters: ["Json files (*.json)" ]
      folder: eaContainer.workingDirectory
      //onAccepted: settingsData.dataFilename = file
      Connections {
          //console.log("loadFileDialog", saveFileDialog.file);
          onAccepted: eaContainer.saveDisplayFormat(saveDispalyDialog2.file);
      }
  }

  Menu {
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
      text: qsTr("&Quit")
      onTriggered: Qt.quit()
    }
  }
  Menu {
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
    title: qsTr("&Help")
    MenuItem {
      text: qsTr("&Assistant")
      onTriggered: eaContainer.startAssistant();
    }
    MenuItem {
      text: qsTr("&About")
      onTriggered: aboutDialogEO.open()
    }

  }
}
