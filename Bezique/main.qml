import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Bezique 1.0
import Qt.labs.settings 1.0
import QtQuick.Window 2.2

ApplicationWindow {
    id: appwin
    visible: true
    //width: 640;   height: 480
    //width: 1280;   height: 720
    width: 660;   height: 360
    //width: Screen.desktopAvailableWidth; height: Screen.desktopAvailableHeight
    //title: qsTr("Bezique " + gameBoard.bottomName  + " " + gameBoard.bottomGamesWon
     //           + " " + gameBoard.topName + " " + gameBoard.topGamesWon)
    title: qsTr("Bezique " + Screen.desktopAvailableHeight  + " " + Screen.desktopAvailableWidth);

   // SwipeView {
     //   id: swipeView
   //     anchors.fill: parent
   //     currentIndex: 0

     //   Page1 {
    //    }

   Page2 {
       id: gameBoard
        property string bottomName: bottomName
        property int topName: bottomName
        property string bottomGamesWon: bottomGamesWon
        property int topGamesWon: topGamesWon
    }

    Settings {
        //property  string    playerName: match.playerName
        //property  string    aiName: match.aiName
        //property  int     playerGamesWon: match.playerGamesWon
        //property  int     aiGamesWon: match.aiGamesWon

        property alias width: appwin.width
        property alias height: appwin.height
    }

   // header: ToolBar {
        // ...
   // }


    StackView {
        anchors.fill: parent
    }

/*
    footer: TabBar {
        id: tabBar
        //currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("First")
        }
        TabButton {
            text: qsTr("Second")
        }
    }
    */
}
