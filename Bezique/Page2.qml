import QtQuick 2.4
import QtQml 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Bezique 1.0

Page2Form {
    Item {
        visible: true
        width: 640
        height: 480
        GameData {
            id: gameData
            faceCard: Card { id: faceCard; }
            humansCardIndex: -1;
            onHumansCardIndexChanged: {
                console.log("cards image",
                    humanPlayer.data[gameData.humansCardIndex].image);
            }
            aisCardIndex: -1
            property bool waitingForCard: false
            humanPlayer: Player {
                id: humanPlayer
                ai: false
                hand: BeziqueHand {
                    id: humanHand
                    property string humanPlayedCardImage: "content/gfx/down.png"
                    cards: [
                        Card { id: card1 },
                        Card { id: card2 },
                        Card { id: card3 },
                        Card { id: card4 },
                        Card { id: card5 },
                        Card { id: card6 },
                        Card { id: card7 },
                        Card { id: card8 }
                    ] //card
                    onEnginPlayedCard: {
                        humanHand.humanPlayedCardImage = data[index].image;
                        data[index].image =  "content/gfx/onePixel.png"
                    }
                } // playerHand: BeziqueHand


            } // humanPlayer: Player

           aiPlayer: Player {
               ai: true
               score: 0
               hand: BeziqueHand {
                    id: aiHand
                    property string aiPlayedCardImage: "content/gfx/up.png"
                    cards: [
                        Card { id: aiCard1 },
                        Card { id: aiCard2 },
                        Card { id: aiCard3 },
                        Card { id: aiCard4 },
                        Card { id: aiCard5 },
                        Card { id: aiCard6 },
                        Card { id: aiCard7 },
                        Card { id: aiCard8 }
                    ] //cards
                    onEnginPlayedCard: {
                        aiHand.aiPlayedCardImage = data[index].image;
                        data[index].image =  "content/gfx/onePixel.png"
                    }
                } // aiHand: BeziqueHand

           } // aiPlayer: Player

           onWaitingForCard:{
               waitingForCard = true;
           }
           onTrickFinished: {
               humanHand.humanPlayedCardImage =  "content/gfx/down.png";
               aiHand.aiPlayedCardImage =  "content/gfx/up.png";
           }
        } //GameData

        HumanCardRow {
            //property bool wantCard: gameData.waitingForCard
        }

        Row {
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: parent.left;
            Rectangle {
                width: 80; height: 100;
                Image {  source: "content/gfx/b1fv.bmp" }
            }
            Rectangle {
                width: 80; height: 100;
                Image { source: faceCard.image }
            }
        } //Row

        Row {
            anchors.centerIn: parent;
            Rectangle {
                width: 80; height: 100;
                //Image {  source: "content/gfx/up.png" }
                Image {  source: aiHand.aiPlayedCardImage }
            }
            Rectangle {
                width: 80; height: 100;
                //Image { source: "content/gfx/down.png" }
                Image {  source: humanHand.humanPlayedCardImage }
            }
        } //Row

        Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.rigth
            Column {
                spacing: 20
                //Rectangle{
                    Text {
                       horizontalAlignment: Text.AlignRight
                       text : "computer: " + gameData.aiPlayer.score.toString()
                    }
               // }
              //  Rectangle {
                    Text {
                        horizontalAlignment: Text.AlignRight
                        text : "human: " + gameData.humanPlayer.score.toString()
                    }
               // }
            }
        }


        AiCardRow {
        }

/*
        Button {
            id: button2
            x: 247
            y: 182
            text: qsTr("Start")
            onClicked: {
                //gameData1.startNewGame();
                swipeView.currentIndex = 1;
                button2.visible = false;
            } // onClicked
        } //Button
*/

    } // Item
}



































