import QtQuick 2.4
import QtQuick.Layouts 1.3
import Bezique 1.0

Page2Form {
    Item {

        GameData {
            id: gameData2
        }

        BeziqueHand {
            id: player1
            score: 9
            cards: [
                Card {
                    id: card1
                    image: "content/gfx/b1fv.bmp"
                    property int cardIndex: 0
                   // CardImage { filename : card1.image }
                },
                Card {
                    id: card2
                    image: "content/gfx/c11.bmp"
                    property int cardIndex: 0
                   // CardImage { filename : card2.image }
                }
                //Card {cardIndex:2 },
                //Card {cardIndex:3 },
                //Card {cardIndex:4 },
                //Card {cardIndex:5 },
                //Card {cardIndex:6 },
                //Card {cardIndex:7 },
                //Card {cardIndex:8 }
            ]

            Row {
                spacing: 50
                Rectangle { Image {source : card1.image; width: 100; height: 100 } }
                Rectangle { Image {source : card2.image; width: 50; height: 50 } }
            }

            //Component.onCompleted: {
            //    console.log("Name of first state:", cards[0].image)
            //    for (var i = 0; i < cards.length; i++)
            //        console.log("state", i, cards[i].image)
            //}
        }



    }
}
