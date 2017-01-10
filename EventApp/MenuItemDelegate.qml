import QtQuick 2.7
import QtQuick.Controls 2.0

ItemDelegate {
    // A simple rounded rectangle for the background
    id: menuItemDelegate
    Rectangle {
        id: itemBackground
        x: eaContainer.eaConstruction.menuDisplay.x
        y: eaContainer.eaConstruction.menuDisplay.x
        width: parent.width - x*2;
        height: parent.height - y*2
        color: eaContainer.eaConstruction.menuDisplay.colour
        border.color: eaContainer.eaConstruction.menuDisplay.borderColour
        border.width: eaContainer.eaConstruction.menuDisplay.borderWidth
        radius: eaContainer.eaConstruction.menuDisplay.radius
    }

    Text {
        id: itemText
        width: parent.width; height: parent.height
        font: eaContainer.eaConstruction.menuDisplay.font
        color: eaContainer.eaConstruction.menuDisplay.fontColour
        style: eaContainer.eaConstruction.menuDisplay.textStyle
        styleColor: eaContainer.eaConstruction.menuDisplay.styleColour
        x: eaContainer.eaConstruction.menuDisplay.xText
        y: eaContainer.eaConstruction.menuDisplay.yText
        verticalAlignment: eaContainer.eaConstruction.menuDisplay.vAlignment
        horizontalAlignment: eaContainer.eaConstruction.menuDisplay.hAlignment

        text: model.title
    }

    highlighted: ListView.isCurrentItem
    onClicked: {
        if (menuListView.currentIndex != index) {
            menuListView.currentIndex = index;
            stackCtl.currentIndex = position + stackCtl.startDrawerId
            titleLabel.text = model.title
        }
        drawer.close();
    }
}
