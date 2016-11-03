import QtQuick 2.4
import QtQml 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Bezique 1.0

Row {
  //anchors.bottom: humanHidden.top
  width: root.cardWidth; height: root.cardHeight;
  CardImage { image: melded1.image; rowPos: 0; }
  CardImage { image: melded2.image; rowPos: 1; }
  CardImage { image: melded3.image; rowPos: 2; }
  CardImage { image: melded4.image; rowPos: 3; }
  CardImage { image: melded5.image; rowPos: 4; }
  CardImage { image: melded6.image; rowPos: 5; }
  CardImage { image: melded7.image; rowPos: 6; }
  CardImage { image: melded8.image; rowPos: 7; }
}
