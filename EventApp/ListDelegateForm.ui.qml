import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import EventAppData 1.0

Item {
    id: drawerDelegate
    //width: 100//parent.width
    //height: 88
    width: 100//eaContainer.eaConstruction.display.width
    height: eaContainer.eaConstruction.display.height
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
        visible: mouseArea.pressed
        //color: eaContainer.eaConstruction.display.pressedColour
    }

    // A simple rounded rectangle for the background
    Rectangle {
        id: itemBackground
        x: eaContainer.eaConstruction.display.x
        y: eaContainer.eaConstruction.display.x
        width: parent.width - x*2;
        height: parent.height - y*2
        color: eaContainer.eaConstruction.display.colour
        border.color: eaContainer.eaConstruction.display.borderColour
        border.width: eaContainer.eaConstruction.display.borderWidth
        radius: eaContainer.eaConstruction.display.radius
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }

    Text {
        id: itemText
        //color: "blue"
        //font.pixelSize: 32
        font: eaContainer.eaConstruction.display.font
        color: eaContainer.eaConstruction.display.fontColour
        style: eaContainer.eaConstruction.display.textStyle
        styleColor: eaContainer.eaConstruction.display.styleColour
        text: modelData
        anchors.left: parent.left
        anchors.leftMargin: 10
        y:10; x:10
    }

    Image {
        id: nextImage
        anchors.right: parent.right
        anchors.rightMargin: 0
        source: "qrc:///shared/images/navigation_next_item.png"
    }

}




















