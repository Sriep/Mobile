import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import EventAppData 1.0

Item {
    id: drawerDelegate
    //width: 100//parent.width
    //height: 88
    //width: //eaContainer.eaConstruction.display.width
    Layout.fillWidth: true
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
    //Row {

        Image {
             clip: true
             id: iconImage
             cache: false
             y: eaContainer.eaConstruction.display.yText
            // y: eaContainer.eaConstruction.display.borderWidth+5
             x: eaContainer.eaConstruction.display.borderWidth + 5
             height: eaContainer.eaConstruction.display.height
                     - 2*eaContainer.eaConstruction.display.borderWidth-10
             //height: eaContainer.eaConstruction.display.height
             //        - 2*eaContainer.eaConstruction.display.borderWidth-10
             fillMode: Image.PreserveAspectFit
             source: icon
             visible: showIcon
         }

        Text {
            id: itemText
            width: parent.width-nextImage.sourceSize.width; height: parent.height
            font: eaContainer.eaConstruction.display.font
            color: eaContainer.eaConstruction.display.fontColour
            style: eaContainer.eaConstruction.display.textStyle
            styleColor: eaContainer.eaConstruction.display.styleColour
            x: eaContainer.eaConstruction.display.xText + iconImage.width
            y: eaContainer.eaConstruction.display.yText
            verticalAlignment: eaContainer.eaConstruction.display.vAlignment
            horizontalAlignment: eaContainer.eaConstruction.display.hAlignment

             //text: icon
           text: title//modelData
        }
   // }
    Image {
        id: nextImage
        anchors.right: parent.right
        anchors.rightMargin: 0
        source: eaContainer.eaConstruction.display.whiteIcons
                ? "qrc:///shared/images/navigation_next_item.png"
                : "qrc:///shared/images/next.png"
        sourceSize.height: eaContainer.eaConstruction.display.height
    }
}




















