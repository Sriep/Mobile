import QtQuick 2.7
import QtQuick.Controls 2.0

ItemDelegate {
    // A simple rounded rectangle for the background
    //id: menuItemDelegate
    width: parent.width
    highlighted: ListView.isCurrentItem
    clip: true
    background: Rectangle {
        id: itemBackground
        //x: eaContainer.eaConstruction.menuDisplay.x
        //y: eaContainer.eaConstruction.menuDisplay.x
        //width: parent.width - x*2;
        //height: parent.height - y*2
       // height: eaContainer.eaConstruction.menuDisplay.height
        //color: eaContainer.eaConstruction.menuDisplay.colour
        //border.color: eaContainer.eaConstruction.menuDisplay.borderColour
        //border.width: eaContainer.eaConstruction.menuDisplay.borderWidth
        //radius: eaContainer.eaConstruction.menuDisplay.radius
    }

    Text {
        id: itemText
        //width: parent.width; height: parent.height
        //font: eaContainer.eaConstruction.menuDisplay.font
       // color: eaContainer.eaConstruction.menuDisplay.fontColour
       // style: eaContainer.eaConstruction.menuDisplay.textStyle
       // styleColor: eaContainer.eaConstruction.menuDisplay.styleColour
        //x: eaContainer.eaConstruction.menuDisplay.xText
        //y: eaContainer.eaConstruction.menuDisplay.yText
       // verticalAlignment: eaContainer.eaConstruction.menuDisplay.vAlignment
       // horizontalAlignment: eaContainer.eaConstruction.menuDisplay.hAlignment

        text: model.title
    }
    onClicked: {
        if (menuListView.currentIndex != index) {
            menuListView.currentIndex = index;
            stackCtl.currentIndex = position + stackCtl.startDrawerId
            titleLabel.text = model.title
        }
        drawer.close();
    }

    function setMenuListDisplayParameters() {
        console.log("setMenuListDisplayParameters");

        itemBackground.x = eaContainer.eaConstruction.menuDisplay.x
        itemBackground.y = eaContainer.eaConstruction.menuDisplay.x
        //itemBackground.width = eaContainer.eaConstruction.menuDisplay.width;
        //itemBackground.height = eaContainer.eaConstruction.menuDisplay.height
        itemBackground.color = eaContainer.eaConstruction.menuDisplay.colour
        itemBackground.border.color = eaContainer.eaConstruction.menuDisplay.borderColour
        itemBackground.border.width = eaContainer.eaConstruction.menuDisplay.borderWidth
        itemBackground.radius = eaContainer.eaConstruction.menuDisplay.radius

        //itemText.width = parent.width; height = parent.height
        itemText.font = eaContainer.eaConstruction.menuDisplay.font
        itemText.color = eaContainer.eaConstruction.menuDisplay.fontColour

        itemText.style = eaContainer.eaConstruction.menuDisplay.textStyle
        itemText.styleColor = eaContainer.eaConstruction.menuDisplay.styleColour
        itemText.x = eaContainer.eaConstruction.menuDisplay.xText
        itemText.y = eaContainer.eaConstruction.menuDisplay.yText
        itemText.verticalAlignment = eaContainer.eaConstruction.menuDisplay.vAlignment
        itemText.horizontalAlignment = eaContainer.eaConstruction.menuDisplay.hAlignment
    }
}
