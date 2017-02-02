import QtQuick 2.7
import QtQuick.Controls 2.0

Drawer {
  id: optionsDrawer
  width: Math.min(eventAppMainPage.width, eventAppMainPage.height) / 3 * 2
  height: eventAppMainPage.height
  edge: Qt.RightEdge

  background: Rectangle {
    color: eaContainer.eaConstruction.menuDisplay.backColour
  }

  ListView {
    id: optionsListView
    currentIndex: -1
    anchors.fill: parent

    Component.onCompleted: {
        popOptionsModel(opetionsModel);
    }

    delegate: MenuItemDelegate {
      id: optionsItemDelegate

      Connections {
          target: optionsListView
          onCurrentItemChanged: {
              console.log("optionsListView onCurrentItemChanged");
              itemBackground.color = menuItemDelegate.highlighted
                      ? eaContainer.eaConstruction.menuDisplay.highlitedColour
                      : eaContainer.eaConstruction.menuDisplay.colour
          }
      }

      Connections {
        target: eaContainer
        onEaConstructionChanged: {
          setToolBarDisplayDataParameters(optionsItemDelegate.itemBackground
                                         , optionsItemDelegate.itemText
                                         , eaContainer.eaConstruction.menuDisplay
                                         , optionsItemDelegate);
        }
      }
      Connections {
        target: optionsDrawer
        onOpen: {
          setToolBarDisplayDataParameters(optionsItemDelegate.itemBackground
                                         , optionsItemDelegate.itemText
                                         , eaContainer.eaConstruction.menuDisplay
                                         , optionsItemDelegate);
        }
      }

      Component.onCompleted: {
          setToolBarDisplayDataParameters(optionsItemDelegate.itemBackground
                       , optionsItemDelegate.itemText
                       , eaContainer.eaConstruction.menuDisplay
                       , optionsItemDelegate);
      }

      Connections {
          target: optionsItemDelegate
          onClicked: {
              var mo = model;
              var mm = model.index;
              switch (model.index) {
              case 98:
                  aboutDialog.open();
                  break;
              case 99:
                  Qt.quit();
                  break;
              default:
                   stackCtl.currentIndex = model.index;
              }
              optionsDrawer.close();
          }
      }

    }

    model: ListModel { id: opetionsModel }
    //
/*
    model: ListModel {
        ListElement { title: eaContainer.eaConstruction.strings.mLogin; index: 1 }
        ListElement { title: eaContainer.eaConstruction.strings.mLoadFKey; index: 2 }
        ListElement { title: eaContainer.eaConstruction.strings.mLoadFFile; index: 3 }
        ListElement { title: eaContainer.eaConstruction.strings.mLoadFFirebase; index: 4 }
        ListElement { title: eaContainer.eaConstruction.strings.mAbout; index: 98 }
        ListElement { title: eaContainer.eaConstruction.strings.mExit; index: 99 }
    }

    model: ListModel {
        ListElement { title: qsTr("Login"); index: 1 }
        ListElement { title: qsTr("Load from Key"); index: 2 }
        ListElement { title: qsTr("Load from file"); index: 3 }
        ListElement { title: qsTr("Load from Firebase"); index: 4 }
        ListElement { title: qsTr("About"); index: 98 }
        ListElement { title: qsTr("Exit"); index: 99 }
    }fruitModel.append({"cost": 5.95, "name":"Pizza"})
  */
    function popOptionsModel(model) {
        model.clear();
        model.append({ "title" : eaContainer.eaConstruction.strings.mLogin,
                               "index" : stackCtl.userLoginId });
        model.append({ "title" : eaContainer.eaConstruction.strings.mLoadFKey,
                               "index" : stackCtl.loadEventKey });
        model.append({ "title" : eaContainer.eaConstruction.strings.mLoadFFile,
                               "index" : stackCtl.loadEventFile });
        model.append({ "title" : eaContainer.eaConstruction.strings.mLoadFFirebase,
                               "index" : stackCtl.loadEventFB });
        model.append({ "title" : eaContainer.eaConstruction.strings.mAbout,
                               "index" : 98 });
        model.append({ "title" : eaContainer.eaConstruction.strings.mExit,
                               "index" : 99 });
        model.sync();
    }

    ScrollIndicator.vertical: ScrollIndicator { }
  }
}




































