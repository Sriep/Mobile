import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Bezique 1.0
import Qt.labs.settings 1.0

ApplicationWindow {
    id: appwin
    visible: true
    width: 640
    height: 480
    title: qsTr("Bezique")

   // SwipeView {
     //   id: swipeView
   //     anchors.fill: parent
   //     currentIndex: 0

     //   Page1 {
    //    }

   Page2 {
        property string playerName: "human"
        property int aiName: 0
        property string playerScore: "computer"
        property int topGamesWon: 0
    }

    Settings {
        //property  string    playerName: match.playerName
        //property  string    aiName: match.aiName
        //property  int     playerGamesWon: match.playerGamesWon
        //property  int     aiGamesWon: match.aiGamesWon

        property alias width: appwin.width
        property alias height: appwin.height
    }


/*
    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("First")
        }
        TabButton {
            text: qsTr("Second")
        }
    }*/
}
