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
    border.width: gameData.waitingForCard && image != root.emptyImage ? 2 : 0

    Image { source: cardImage.image }
    MouseArea {
        id: cimageMouseArea
        anchors.fill: parent;
        signal playedCardIndex(int rowPos);
        onClicked: {
        if (gameData.waitingForCard) {
            //gameData.humansCard = rowPos;
            gameData.waitingForCard = false;
            gameData.cardPlayed(rowPos, melded);
        }
    }}


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
