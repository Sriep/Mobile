import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Bezique 1.0

Page2Form {
    Item {
        GameData {
            id: gameData2
        }

        Button {
            id: button2
            x: 247
            y: 182
            text: qsTr("Start")

            onClicked: {
                gameData1.startNewGame();
                swipeView.currentIndex = 1;
                button2.visible = false;
            }
        }

        BeziqueHand {
            id: player1
            score: 9
            cards: [
                Card {
                    id: card1
                    image: "content/gfx/b1fv.bmp"
                },
                Card {
                    id: card2
                    image: "content/gfx/b1fv.bmp"
                },
                Card {
                    id: card3
                    image: "content/gfx/b1fv.bmp"
                },
                Card {
                    id: card4
                    image: "content/gfx/b1fv.bmp"
                },
                Card {
                    id: card5
                    image: "content/gfx/b1fv.bmp"
                },
                Card {
                    id: card6
                    image: "content/gfx/b1fv.bmp"
                },
                Card {
                    id: card7
                    image: "content/gfx/b1fv.bmp"
                },
                Card {
                    id: card8
                    image: "content/gfx/b1fv.bmp"
                }
            ]

            Row {
                //anchors.bottom: parent.top;
                y: 0
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
                    Image { source: card1.image }
                }
                Rectangle {
                    id: rect5
                    width: 80; height: 100;
                    Image {  source:  card2.image}
                }
                Rectangle {
                    id: rect6
                    width: 80; height: 100;
                    Image {  source:  card3.image }
                }
                Rectangle {
                    id: rect7
                    width: 80; height: 100;
                    Image { source: card1.image }
                }
                Rectangle {
                    id: rect8
                    width: 80; height: 100;
                    Image {  source:  card2.image}
                }

            }
        }
/*


            Component.onCompleted: {
                console.log("Name of first state:", cards[0].image)
                for (var i = 0; i < cards.length; i++)
                    console.log("state", i, cards[i].image)
            }
   */





    }
}
