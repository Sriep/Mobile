import QtQuick 2.0

Item {
        id: displedImage
        property string filename: "content/gfx/c01.bmp"
        property int cIndex: 0
        x: 0
        Rectangle {
            Image {
                source: displedImage.filename
            }
        }

        MouseArea {
          anchors.fill: parent
          onClicked: {
            parent.selectCard(index, mouse.x, mouse.y);
          }
        }
}
