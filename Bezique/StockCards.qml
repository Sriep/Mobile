import QtQuick 2.4
import QtQml 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Bezique 1.0

Row {
    Rectangle {
        //width: 80; height: 100;
        width: root.cardWidth; height: root.cardHeight;
        // Image {  source: "content/gfx/b1fv.bmp" }
        Image {  source: root.backImage }
    }
    Rectangle {
        //width: 80; height: 100;
        width: root.cardWidth; height: root.cardHeight;
        Image { source: faceCard.image }
    }
    Rectangle {
        //width: 80; height: 100;
        width: root.cardWidth; height: root.cardHeight;
        //Image { source: faceCard.image }
    }
    Rectangle {
        //width: 80; height: 100;
        width: root.cardWidth; height: root.cardHeight;
        //Image { source: faceCard.image }
    }

    TrickCards {
       // anchors.centerIn: parent
    } //Row
}
