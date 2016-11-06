import QtQuick 2.4
import QtQml 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Bezique 1.0

Row {
  spacing: 5
  //anchors.bottom: humanHidden.top
  width: root.cardWidth; height: root.cardHeight;
  CardImage { image: melded1.image; rowPos: 0; melded: true; canMeld: melded1.canMeld }
  CardImage { image: melded2.image; rowPos: 1; melded: true; canMeld: melded2.canMeld }
  CardImage { image: melded3.image; rowPos: 2; melded: true; canMeld: melded3.canMeld }
  CardImage { image: melded4.image; rowPos: 3; melded: true; canMeld: melded4.canMeld }
  CardImage { image: melded5.image; rowPos: 4; melded: true; canMeld: melded5.canMeld }
  CardImage { image: melded6.image; rowPos: 5; melded: true; canMeld: melded6.canMeld }
  CardImage { image: melded7.image; rowPos: 6; melded: true; canMeld: melded7.canMeld }
  CardImage { image: melded8.image; rowPos: 7; melded: true; canMeld: melded8.canMeld }
}
