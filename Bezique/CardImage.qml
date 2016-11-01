import QtQuick 2.0

Rectangle {
    id: cardImage
    //width: 80; height: 100;
    width: 40; height: 100;
    property string image : "content/gfx/b1fv.bmp"
    property int rowPos : 0

    Image { source: cardImage.image }
    MouseArea {
        id: cimageMouseArea
        anchors.fill: parent;
        signal playedCardIndex(int rowPos);
        onClicked: {
        if (gameData.waitingForCard) {
            gameData.humansCardIndex = rowPos;
            gameData.waitingForCard = false;
            gameData.cardPlayed(rowPos);
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
