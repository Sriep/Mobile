import QtQuick 2.0

Rectangle {
    id: cardImage
    //width: 80; height: 100;
    width: root.cardWidth; height: root.cardHeight;
    property string image: "content/gfx/b1fv.bmp"
    property bool canMeld: false;

    //property Card hcard: hidden1;
    //property string image: hcard.image;

    property int rowPos: 0
    property bool melded: false
    border.width: {
        if (image === root.emptyImage)
            return 0;
        if (gameData.waitingForCard
            || (gameData.humanMelding && canMeld) )
            return 2;
        return 0;
    }
    border.color: {
        if (cardImage.image !== root.emptyImage) {
            if (gameData.humanMelding)  {
                if (canMeld)
                    return "red";
            } else if (gameData.waitingForCard) {
                return "yellow";
            }
        }
    }

    Image { source: cardImage.image }
    MouseArea {
        id: cimageMouseArea
        anchors.fill: parent;
        signal playedCardIndex(int rowPos);
        onClicked: {
            if (gameData.waitingForCard) {
                gameData.waitingForCard = false;
                gameData.cardPlayed(rowPos, melded);
            } else if (gameData.humanMelding) {
                gameData.humanMelding = false;
                gameData.humanMeld(true, rowPos);
            }
        }
    }


}

/*
Flipable {
    property alias source: frontImage.source
    property bool flipped: true
    width: front.width; height: front.height
    front: Image { id: frontImage }
    back: Image { source: "content/gfx/b1fv.bmp" }
    state: "back"
    MouseArea {
        anchors.fill: parent;
        onClicked: {
            container.flipped = !container.flipped
        }
    }
}
*/
