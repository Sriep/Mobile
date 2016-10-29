import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Bezique 1.0

ApplicationWindow {
    id: appwin
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    GameData {
        id: gameData1
    }
    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 0

        Page1 {
        }

        Page2 {
            id: page2id
            Label {
                text: qsTr("Second page")
                anchors.centerIn: parent
            }
        }

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
