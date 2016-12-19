import QtQuick 2.2

Item {
    id: drawerDelegate
    width: 100//parent.width
    height: 88
    property alias mouseArea: mouseArea
    property alias nextImage: nextImage
    property alias itemBackground: itemBackground
    property alias itemText: itemText
    property alias itemPresseed: itemPresseed

    property alias text: itemText.text
    signal clicked

    Rectangle {
        id: itemPresseed
        anchors.fill: parent
        color: "#11ffffff"
        visible: mouseArea.pressed
    }

    Rectangle {
        id: itemBackground
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 15
        height: 1
        color: "#424246"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        //onClicked: stackCtl.currentIndex = position + 2;
    }

    Text {
        id: itemText
        color: "blue"
        font.pixelSize: 32
        text: modelData
        anchors.left: parent.left
        anchors.leftMargin: 0
    }

    Image {
        id: nextImage
        anchors.right: parent.right
        anchors.rightMargin: 0
        source: "qrc:///shared/images/navigation_next_item.png"
    }

}
