import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Bezique 1.0

Page2Form {
    Item {
        visible: true
        width: 640
        height: 480
        GameData {
            id: gameData2
            faceCard: Card { id: faceCard; }
            humanPlayer: Player {
                ai: false
                hand: BeziqueHand {
                    cards: [
                        Card { id: card1 },
                        Card { id: card2 },
                        Card { id: card3 },
                        Card { id: card4 },
                        Card { id: card5 },
                        Card { id: card6 },
                        Card { id: card7 },
                        Card { id: card8 }
                    ] //cards
                    /*
                    Component.onCompleted: {
                        console.log("Name of first state:", cards[0].image)
                        for (var i = 0; i < cards.length; i++)
                            console.log("state", i, cards[i].image)
                    }
                    */
                } // playerHand: BeziqueHand


            } // humanPlayer: Player

           aiPlayer: Player {
               ai: true
               hand: BeziqueHand {
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
                } // aiHand: BeziqueHand
           } // aiPlayer: Player

        } //GameData

        Row {
            id: playerRow
            anchors.bottom: parent.bottom
            Rectangle {
                id: rect1
                width: 80; height: 100;
                Image { source: card1.image }
            }
            Rectangle {
                id: rect2
                width: 80; height: 100;
                Image {  source:  card2.image}
            }
            Rectangle {
                id: rect3
                width: 80; height: 100;
                Image {  source:  card3.image }
            }
            Rectangle {
                id: rect4
                width: 80; height: 100;
                Image { source: card4.image }
            }
            Rectangle {
                id: rect5
                width: 80; height: 100;
                Image {  source:  card5.image}
            }
            Rectangle {
                id: rect6
                width: 80; height: 100;
                Image {  source:  card6.image }
            }
            Rectangle {
                id: rect7
                width: 80; height: 100;
                Image { source: card7.image }
            }
            Rectangle {
                id: rect8
                width: 80; height: 100;
                Image {  source:  card8.image}
            }
        } //Row

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
            Rectangle {
                id: airect1
                width: 80; height: 100;
                Image { source: aiCard1.image }
            }
            Rectangle {
                id: airect2
                width: 80; height: 100;
                Image {  source:  aiCard2.image}
            }
            Rectangle {
                id: airect3
                width: 80; height: 100;
                Image {  source:  aiCard3.image }
            }
            Rectangle {
                id: airect4
                width: 80; height: 100;
                Image { source: aiCard4.image }
            }
            Rectangle {
                id: airect5
                width: 80; height: 100;
                Image {  source:  aiCard5.image}
            }
            Rectangle {
                id: airect6
                width: 80; height: 100;
                Image {  source:  aiCard6.image }
            }
            Rectangle {
                id: airect7
                width: 80; height: 100;
                Image { source: aiCard7.image }
            }
            Rectangle {
                id: airect8
                width: 80; height: 100;
                Image {  source:  aiCard8.image}
            }
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

    }
}
