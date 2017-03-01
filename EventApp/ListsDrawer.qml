import QtQuick 2.7
import QtQuick.Controls 2.0

Drawer {
  id: listsDrawer
  width: Math.min(eventAppMainPage.width, eventAppMainPage.height) / 3 * 2
  height: eventAppMainPage.height
  edge: Qt.LeftEdge

  background: Rectangle {
    color: eaContainer.eaConstruction.menuDisplay.backColour
  }
   
  ListView {
    id: menuListView
    currentIndex: -1
    anchors.fill: parent
    //signal upadeteDisplay()
    
    delegate: MenuItemDelegate {
      id: menuItemDelegate

      Connections {
          target: menuListView
          onCurrentItemChanged: {
              console.log("menuListView onCurrentItemChanged");
              itemBackground.color = menuItemDelegate.highlighted
                      ? eaContainer.eaConstruction.menuDisplay.highlitedColour
                      : eaContainer.eaConstruction.menuDisplay.colour
          }
      }
      
      Connections {
        target: eaContainer
        onEaConstructionChanged: {
          setMenuDisplayDataParameters(menuItemDelegate.itemBackground
                                         , menuItemDelegate.iconMenuImage
                                         , menuItemDelegate.itemText
                                         , eaContainer.eaConstruction.menuDisplay
                                         , menuItemDelegate);
        }
      }
      Connections {
        target: listsDrawer
        onOpen: {
          setMenuDisplayDataParameters(menuItemDelegate.itemBackground
                                         , menuItemDelegate.iconMenuImage
                                         , menuItemDelegate.itemText
                                         , eaContainer.eaConstruction.menuDisplay
                                         , menuItemDelegate);
        }
      }/*
      Connections {
        target: menuListView
        onUpadeteDisplay: {
          setMenuDisplayDataParameters(menuItemDelegate.itemBackground
                                         , menuItemDelegate.itemText
                                         , eaContainer.eaConstruction.menuDisplay
                                         , menuItemDelegate);
        }
      }
*/
      Component.onCompleted: {
          setMenuDisplayDataParameters(menuItemDelegate.itemBackground
                       , menuItemDelegate.iconMenuImage
                       , menuItemDelegate.itemText
                       , eaContainer.eaConstruction.menuDisplay
                       , menuItemDelegate);
      }

      Connections {
          target: menuItemDelegate
          onClicked: {
              if (menuListView.currentIndex != index) {
                  menuListView.currentIndex = index;
                  stackCtl.currentIndex = position + stackCtl.startDrawerId
                  titleLabel.text = model.title
              }
              listsDrawer.close();
          }
      }
      
    }
    model: stackCtl.drawerModel
    
    ScrollIndicator.vertical: ScrollIndicator { }
  }
}
