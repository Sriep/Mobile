import QtQuick 2.4
import QtQml 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Bezique 1.0

Page2Form {
    Item {
        id: root
        visible: true
        width: 640
        height: 480
        property int cardWidth: 46
        property int cardHeight: 66
        property string emptyImage: "content/gfx/onePixel.png"
        property string backImage: "content/gfx/tinydeck/back111.gif"

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

            property bool aiPlayedCard: aisCard.image !== root.emptyImage

            property bool waitingForCard: false
            onWaitingForCard: waitingForCard = true;

            property bool humanMelding: false
            onWaitingForMeld: { humanMelding = true; waitingForCard = false; }
            onMelded: humanMelding = false;

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
               score: 0
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

        HumanCardRow {
            id: humanHidden
            //property bool wantCard: gameData.waitingForCard
        }

        Row {
            anchors.bottom: humanHidden.top
            CardImage { image: melded1.image; rowPos: 0; }
            CardImage { image: melded2.image; rowPos: 1; }
            CardImage { image: melded3.image; rowPos: 2; }
            CardImage { image: melded4.image; rowPos: 3; }
            CardImage { image: melded5.image; rowPos: 4; }
            CardImage { image: melded6.image; rowPos: 5; }
            CardImage { image: melded7.image; rowPos: 6; }
            CardImage { image: melded8.image; rowPos: 7; }
        } //Row

        StockCards {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        } //Row

        TrickCards {
            anchors.centerIn: parent
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
            id: aiHidden
        }

        AiMeldRow {
            anchors.top: aiHidden.bottom
        } //Row

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



































