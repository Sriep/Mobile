                           import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qrc:///shared"

Item {
    id: dispalyTabForm
    width: 600; height: 800;
    property alias eaCommonDisplayPara: eaCommonDisplayPara

        Column {
            width: parent.width; height: parent.height -100
            spacing: 10
            x:10; y:10
            TabBar {
                //width: parent.width; //height: parent.height
                width: 520
                id: dataDisplayTab
                Layout.minimumWidth: 360
                Layout.preferredWidth: 480
                TabButton {
                    text: qsTr("Common")
                }
                TabButton {
                    text: qsTr("Drawer")
                }
                TabButton {
                    text: qsTr("Menu")
                }
                TabButton {
                    text: qsTr("Toolbar")
                }
                TabButton {
                    text: qsTr("Strings")
                }
            }
            //DataListImage {}

            clip: true
            Rectangle {
                id: rectSL
                width: 520; height: 720
                border.width : 1; border.color : "green"

                StackLayout {
                    id: itemDisplayParaStack
                    currentIndex: dataDisplayTab.currentIndex
                    x:10; y: 10
                    width: parent.width - 2*x; height: parent.height - 2*y
                    clip: true
                    property int formatedListStack: 1
                    property int manualListItem: 2

                    EaCommonDisplayPara {
                        id: eaCommonDisplayPara
                    }

                    EaDisplayPara {
                        id: paraDrawer
                        property var featuredDisplay: eaContainer.eaConstruction.display
                        property string title: "Drawer display parameters"
                    }

                    EaDisplayPara {
                        id: paraMenu
                        property var featuredDisplay: eaContainer.eaConstruction.menuDisplay
                        property string title: "Menu display parameters"
                    }

                    EaDisplayPara {
                        id: paraToolBar
                        property var featuredDisplay: eaContainer.eaConstruction.toolBarDisplay
                        property string title: "Tool bar display parameters"
                    }

                    EaStrings {
                        id: eaStrings
                    }

                } //StackLayout
            }  //Rectangle
       } //ColumnLayout
}
