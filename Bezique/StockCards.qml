import QtQuick 2.4
import QtQml 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Bezique 1.0

Row {
    spacing: 5
    Rectangle {
        color: root.backColor;
        width: root.cardWidth; height: root.cardHeight;
        // Image {  source: "content/gfx/b1fv.bmp" }
        Image {  source: root.backImage }
    }
    Rectangle {
        color: root.backColor;
        width: root.cardWidth; height: root.cardHeight;
        Image { source: faceCard.image }
    }
    Rectangle {
        color: root.backColor;
        width: root.cardWidth; height: root.cardHeight;
        //Image { source: faceCard.image }
    }
    Rectangle {
        id: statusText
        color: root.backColor;
        width: root.cardWidth*3; height: root.cardHeight;

        //property string message: "Play"
        //Image { source: faceCard.image }
        Text {
            horizontalAlignment:  Text.AlignHCenter
            //font.bold: bold
            font.family: "Helvetica"
            font.pointSize: 20
            color: "white"
            text: gameData.statusMessage
        }
    }
/*
    Rectangle {
        color: root.backColor;
        width: root.cardWidth; height: root.cardHeight;
        //Image { source: faceCard.image }
    }
    Rectangle {
        color: root.backColor;
        width: root.cardWidth; height: root.cardHeight;
        //Image { source: faceCard.image }
    }
*/
    TrickCards {
       // anchors.centerIn: parent
    } //Row
}
