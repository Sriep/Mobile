import QtQuick 2.0

Rectangle {
    id: cardImage
    //width: 80; height: 100;
    width: root.cardWidth; height: root.cardHeight;
    property string image: "content/gfx/b1fv.bmp"
    property int rowPos: 0
    property bool melded: false

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
