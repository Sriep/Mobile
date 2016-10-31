import QtQuick 2.0

Row {
    id: playerRow
    anchors.bottom: parent.bottom
    CardImage { image: card1.image; rowPos: 0; }
    CardImage { image: card2.image; rowPos: 1; }
    CardImage { image: card2.image; rowPos: 1; }
    CardImage { image: card3.image; rowPos: 2; }
    CardImage { image: card4.image; rowPos: 3; }
    CardImage { image: card5.image; rowPos: 4; }
    CardImage { image: card6.image; rowPos: 5; }
    CardImage { image: card7.image; rowPos: 6; }
    CardImage { image: card8.image; rowPos: 7; }
 /*   Rectangle {
        width: 80; height: 100;
        Image { source: card1.image }
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if (gameData.waitingForCard) {
                    //humanHand.humanPlayedCardImage = card1.image;
                    //card1.image = "content/gfx/onePixel.png"
                    gameData.humansCardIndex = 0;
                    gameData.waitingForCard = false;
                    gameData.cardPlayed(0);
                }
            }
        }
    }

    Rectangle {
        width: 80; height: 100;
        Image { source: card2.image }
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if (gameData.waitingForCard) {
                    humanHand.humanPlayedCardImage = card2.image;
                    card2.image = "content/gfx/onePixel.png"
                    gameData.waitingForCard = false;
                    gameData.humansCardIndex = 1;
                }
            }
        }
    }
    Rectangle {
        width: 80; height: 100;
        Image { source: card3.image }
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if (gameData.waitingForCard) {
                    humanHand.humanPlayedCardImage = card3.image;
                    card3.image = "content/gfx/onePixel.png";
                    gameData.waitingForCard = false;
                    gameData.humansCardIndex = 2;
                }
            }
        }
    }
    Rectangle {
        width: 80; height: 100;
        Image { source: card4.image }
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if (gameData.waitingForCard) {
                    humanHand.humanPlayedCardImage = card4.image;
                    card4.image = "content/gfx/onePixel.png"
                    gameData.waitingForCard = false;
                    gameData.humansCardIndex = 3;
                }
            }
        }
    }
    Rectangle {
        width: 80; height: 100;
        Image { source: card5.image }
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if (gameData.waitingForCard) {
                    humanHand.humanPlayedCardImage = parent.image;
                    card5.image = "content/gfx/onePixel.png";
                    gameData.waitingForCard = false;
                    gameData.humansCardIndex = 4;
                }
            }
        }
    }
    Rectangle {
        width: 80; height: 100;
        Image { source: card6.image }
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if (gameData.waitingForCard) {
                    humanHand.humanPlayedCardImage = card6.image;
                    card6.image = "content/gfx/onePixel.png";
                    gameData.waitingForCard = false;
                    gameData.humansCardIndex = 5;
                }
            }
        }
    }
    Rectangle {
        width: 80; height: 100;
        Image { source: card7.image }
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if (gameData.waitingForCard) {
                    humanHand.humanPlayedCardImage = card7.image;
                    card7.image = "content/gfx/onePixel.png";
                    gameData.waitingForCard = false;
                    gameData.humansCardIndex = 6;
                }
            }
        }
    }
    Rectangle {
        width: 80; height: 100;
        Image { source: card8.image }
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if (gameData.waitingForCard) {
                    humanHand.humanPlayedCardImage = card8.image;
                    card8.image = "content/gfx/onePixel.png";
                    gameData.waitingForCard = false;
                    gameData.humansCardIndex = 7;
                }
            }
        }
    }*/

} //Row
