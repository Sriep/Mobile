import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Bezique 1.0

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


            property string bottomName: "human"
            property int bottomGamesWon: 0
            property string topName: "computer"
            property int topGamesWon: 0

            //id: page2id
            //Label {
            //    text: qsTr("Second page")
            //    anchors.centerIn: parent
            //}
   //     }

        /*Image {
            source: "content/gfx/button-play.png"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 60
            MouseArea {
                anchors.fill: parent
                onClicked: newGameScreen.startButtonClicked()
            }
        }*/
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
