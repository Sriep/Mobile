import QtQuick 2.0

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
