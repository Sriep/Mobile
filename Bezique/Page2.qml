import QtQuick 2.4
import QtQml 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import Bezique 1.0

//Page2 {
    Item {

        BeziqueMatch {
            id: match
            playerName: "human"
            aiName: "ai"
            playerGamesWon: 0
            aiGamesWon: 0
        }

        id: root
        visible: true
        width: 640
        height: 480
        property int cardWidth: 46
        property int cardHeight: 66
        property string emptyImage: "content/gfx/onePixelGreen.png"
        property string backImage: "content/gfx/tinydeck/back111.gif"
        property string backColor: "green"

        Settings {
            property  string    playerName: match.playerName
            property  string    aiName: match.aiName
            property  int     playerGamesWon: match.playerGamesWon
            property  int     aiGamesWon: match.aiGamesWon
        }

        Rectangle {
            width: 640; height: 480;
            color: root.backColor;
            MouseArea {
                id: gameArea
                anchors.fill: parent;
                onClicked: {
                    console.log("gameData.drawCard",gameData.drawCard);
                    console.log("gameData.isEndgame",gameData.isEndgame);
                    console.log("gameData.statusMessage",gameData.statusMessage);
                    console.log("gameData.waitNextTrick",gameData.waitNextTrick);
                    if (gameData.drawCard) {
                        gameData.drawCard = false;
                        gameData.statusMessage = ""
                        gameData.finishTrick();
                    } else if (gameData.waitNextTrick
                               && gameData.isEndgame) {
                        gameData.waitNextTrick = false;
                        gameData.statusMessage = ""
                        gameData.scoreEndTrick();
                    }
                }
            }
        }

        GameData {
            id: gameData
            faceCard: Card { id: faceCard; }
            onHumansCardChanged: {
              //  console.log("cards image",
              //      humanPlayer.data[gameData.humansCardIndex].image);
            }
            //gameData.aisCard.image
            //gameData.humansCard.image
            aisCard: Card {}
            humansCard: Card {}
            //trumps:

            property bool aiPlayedCard: aisCard.image !== root.emptyImage
            property string statusMessage: "Play"
            property bool waitingForCard: false
            property bool humanMelding: false
            property bool drawCard: false
            property string stockImage: root.backImage
            property bool isEndgame: false;
            property bool waitNextTrick: false

            onWaitingForCard: {
                waitingForCard = true;
                statusMessage = "Play";
            }

            onFollowedToTrick: {
                if (isEndgame) {
                    waitNextTrick = true;
                    statusMessage = "Next trick";
                }
            }

            onStartEndgame: {
               stockImage =  root.emptyImage;
               isEndgame = true;
            }

            onHandsDealt: {
                stockImage = root.backImage;
                isEndgame = false;
            }

            onWaitingForMeld: {
                humanMelding = true;
                waitingForCard = false;
                statusMessage = "Meld";
            }
            onMelded: {
                humanMelding = false;
                statusMessage = ""
            }
            onDrawing: {
                drawCard = true;
                statusMessage = "Draw";
            }

            humanPlayer: Player {
                id: humanPlayer
                ai: false
                hand: BeziqueHand {
                    id: humanHand
                    //property string humanPlayedCardImage: "content/gfx/down.png"
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
                        //humanHand.humanPlayedCardImage = cards[index].image;
                        //data[index].image =  "content/gfx/onePixel.png"
                    }
                    hiddedCards: [
                        Card { id: hidden1 },
                        Card { id: hidden2 },
                        Card { id: hidden3 },
                        Card { id: hidden4 },
                        Card { id: hidden5 },
                        Card { id: hidden6 },
                        Card { id: hidden7 },
                        Card { id: hidden8 }
                    ] //card
                    meldedCards: [
                        Card { id: melded1 },
                        Card { id: melded2 },
                        Card { id: melded3 },
                        Card { id: melded4 },
                        Card { id: melded5 },
                        Card { id: melded6 },
                        Card { id: melded7 },
                        Card { id: melded8 }
                    ] //card

                } // playerHand: BeziqueHand
            } // humanPlayer: Player

           aiPlayer: Player {
               ai: true
               //score: 0
               hand: BeziqueHand {
                    id: aiHand
                    //property string aiPlayedCardImage: "content/gfx/up.png"
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
                        //aiHand.aiPlayedCardImage = data[index].image;
                        //console.log("index", index);
                        //console.log("image", cards[index].imag);
                        //data[index].image =  "content/gfx/onePixel.png"
                    }
                    hiddedCards: [
                        Card { id: aiHidden1 },
                        Card { id: aiHidden2 },
                        Card { id: aiHidden3 },
                        Card { id: aiHidden4 },
                        Card { id: aiHidden5 },
                        Card { id: aiHidden6 },
                        Card { id: aiHidden7 },
                        Card { id: aiHidden8 }
                    ] //card
                   meldedCards: [
                        Card { id: aiMelded1 },
                        Card { id: aiMelded2 },
                        Card { id: aiMelded3 },
                        Card { id: aiMelded4 },
                        Card { id: aiMelded5 },
                        Card { id: aiMelded6 },
                        Card { id: aiMelded7 },
                        Card { id: aiMelded8 }
                    ] //card

                } // aiHand: BeziqueHand

           } // aiPlayer: Player


           onTrickFinished: {
               gameData.humansCard.image =  "content/gfx/down.png";
               gameData.aisCard.image =  "content/gfx/up.png";
           }
        } //GameData

        Column {
            spacing: 5
           // anchors.left: parent.left
           // anchors.verticalCenter: parent.verticalCenter

            //color: "green";
            AiCardRow {
                id: aiHidden
                width: root.cardWidth; height: root.cardHeight;
            }

            AiMeldRow {
                //anchors.top: aiHidden.bottom
                width: root.cardWidth; height: root.cardHeight;
            } //Row

            Rectangle {
                color: root.backColor;
                width: 100; height: 10;
                Text {
                   color: (gameData.trumps === 0 || gameData.trumps === 2)
                          ? "red" : "black";
                   text : {
                       switch (gameData.trumps) {
                           case 0:
                               return "\u2666";
                           case 1:
                               return "\u2663";
                           case 2:
                               return "\u2665";
                           case 3:
                               return "\u2660";
                           default:
                               return "";
                       } // switch
                   } // text
                } // Text
            } // Rectangle

            Rectangle {
                color: root.backColor;
                width: 100; height: 10;
                Text {
                   color: "white"
                   //horizontalAlignment: Text.AlignTop
                   text : {
                       //"computer: " + gameData.aiPlayer.score.toString()
                       gameData.aiPlayer.score.toString()
                   }
                }
            }
            StockCards {
                id: stock;
                width: root.cardWidth; height: root.cardHeight;
                //anchors.left: parent.left
               // anchors.verticalCenter: parent.verticalCenter
            } //Row

            Rectangle {
                color: root.backColor;
                width: 100; height: 10;
                Text {
                    color: "white"
                    //horizontalAlignment: Text.AlignBottom
                    text : gameData.humanPlayer.score.toString()
                    //text : "human: " + gameData.humanPlayer.score.toString()
                }
            }

            HumanMeldRow {
                width: root.cardWidth; height: root.cardHeight;
            } //Row

            HumanCardRow {
                width: root.cardWidth; height: root.cardHeight;
                id: humanHidden
            }
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
//}




































