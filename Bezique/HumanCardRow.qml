import QtQuick 2.0

Row {
    //id: humanHidden
    spacing: 5
    //anchors.bottom: parent.bottom
    width: root.cardWidth; height: root.cardHeight;
    CardImage { image: hidden1.image; rowPos: 0; canMeld: hidden1.canMeld }
    CardImage { image: hidden2.image; rowPos: 1; canMeld: hidden2.canMeld }
    CardImage { image: hidden3.image; rowPos: 2; canMeld: hidden3.canMeld }
    CardImage { image: hidden4.image; rowPos: 3; canMeld: hidden4.canMeld }
    CardImage { image: hidden5.image; rowPos: 4; canMeld: hidden5.canMeld }
    CardImage { image: hidden6.image; rowPos: 5; canMeld: hidden6.canMeld }
    CardImage { image: hidden7.image; rowPos: 6; canMeld: hidden7.canMeld }
    CardImage { image: hidden8.image; rowPos: 7; canMeld: hidden8.canMeld }
    /*
    CardImage { hcard: hidden1; rowPos: 0; }
    CardImage { hcard: hidden2; rowPos: 1; }
    CardImage { hcard: hidden3; rowPos: 2; }
    CardImage { hcard: hidden4; rowPos: 3; }
    CardImage { hcard: hidden5; rowPos: 4; }
    CardImage { hcard: hidden6; rowPos: 5; }
    CardImage { hcard: hidden7; rowPos: 6; }
    CardImage { hcard: hidden8; rowPos: 7; }*/
} //Row
