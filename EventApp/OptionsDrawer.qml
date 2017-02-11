import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

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
    Connections {
        target: eaContainer.eaConstruction.strings
        onStringsChanged: {
            console.log("onStringsChanged");
            var  vvv = optionsListView
            optionsListView.popOptionsModel(opetionsModel)
        }
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
          setOptionsMenuDisplayParamters(optionsItemDelegate.itemBackground
                                         , optionsItemDelegate.iconMenuImage
                                         , optionsItemDelegate.itemText
                                         , eaContainer.eaConstruction.menuDisplay
                                         , optionsItemDelegate);
        }
      }
      Connections {
        target: optionsDrawer
        onOpen: {
          setOptionsMenuDisplayParamters(optionsItemDelegate.itemBackground
                                         , optionsItemDelegate.iconMenuImage
                                         , optionsItemDelegate.itemText
                                         , eaContainer.eaConstruction.menuDisplay
                                         , optionsItemDelegate);
        }
      }

      Component.onCompleted: {
          setOptionsMenuDisplayParamters(optionsItemDelegate.itemBackground
                        , optionsItemDelegate.iconMenuImage
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
        //model.sync();
    }

    ScrollIndicator.vertical: ScrollIndicator { }
  }

  Dialog {
      id: aboutDialog
      title:  eaContainer.eaConstruction.strings.mAbout

      Column {
          id: aboutColumn
          spacing: 20

          Label {
              width: aboutDialog.availableWidth
              text:  eaContainer.eaConstruction.strings.aboutText
              wrapMode: Label.Wrap
              font.pixelSize: 12
          }

          Label {
              width: aboutDialog.availableWidth
              text: "Easy event app \n"
                    + "www.easyeventapp.co.uk\n"
                    + "Make easy event apps.\n"
              wrapMode: Label.Wrap
              font.pixelSize: 12
          }
      }
  }
}




































