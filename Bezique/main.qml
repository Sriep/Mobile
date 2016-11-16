import QtQuick 2.2
import QtQuick.Controls 1.2
import "content"
import Qt.labs.settings 1.0
import QtQuick.Window 2.2

ApplicationWindow {
    id: appwin
    visible: true
    width: 800
    height: 1280
    title: qsTr("Bezique " + stackView.depth);
/*
    menuBar: MenuBar {
        Menu {
            id: beziaueMenu
            title: "Bezique"
            MenuItem {
                text: "Continue"
                onTriggered: stackView.pop(null);
            }

            MenuItem {
                text: "Restart Match"
                onTriggered: {
                    gameBoard.restartGame = ture;
                    stackView.pop(null);
                }
            }

            MenuItem {
                text: "Options"
                onTriggered: stackView.push(Options);
            }

            MenuItem {
                text: "Exit"
                onTriggered: Qt.quit();
            }
        }
    }
*/
/*
     toolBar: BorderImage {
         border.bottom: 8
         source: "images/toolbar.png"
         width: parent.width
         height: stackView.depth > 1 ? 100 : 0// 100

         Rectangle {
             id: backButton
             width: opacity ? 60 : 0
             anchors.left: parent.left
             anchors.leftMargin: 20
             opacity: stackView.depth > 1 ? 1 : 0
             anchors.verticalCenter: parent.verticalCenter
             antialiasing: true
             height: stackView.depth > 1 ? 60 : 0
             radius: 4
             color: backmouse.pressed ? "#222" : "transparent"
             Behavior on opacity { NumberAnimation{} }
             Image {
                 anchors.verticalCenter: parent.verticalCenter
                 source: "images/navigation_previous_item.png"
             }
             MouseArea {
                 id: backmouse
                 anchors.fill: parent
                 anchors.margins: -10
                 onClicked: stackView.pop()
             }
         }

         Text {
             font.pixelSize: stackView.depth > 1 ? 42 : 0
             Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
             x: backButton.x + backButton.width + 20
             anchors.verticalCenter: parent.verticalCenter
             color: "white"
             text: stackView.depth > 1 ? "Bezique Options" : "";
         }
     }

*/

    Page2 {
        id: gameBoard
         property string bottomName: bottomName
         property int topName: bottomName
         property string bottomGamesWon: bottomGamesWon
         property int topGamesWon: topGamesWon
         property bool restartGame: restartGame = false
     }



    StackView {
        id: stackView
        anchors.fill: parent
        // Implements back key navigation
        focus: true
        Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1) {
                             stackView.pop();
                             event.accepted = true;
                         }

        initialItem :  gameBoard
    }

    Settings {
        property alias width: appwin.width
        property alias height: appwin.height
    }

}
