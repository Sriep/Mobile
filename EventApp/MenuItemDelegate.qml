import QtQuick 2.7
import QtQuick.Controls 2.0

ItemDelegate {
    property  alias itemBackground: itemBackground
    property  alias itemText: itemText

    width: parent.width
    highlighted: ListView.isCurrentItem
    clip: true
    background: Rectangle {
        id: itemBackground
        x: eaContainer.eaConstruction.menuDisplay.x
        y: eaContainer.eaConstruction.menuDisplay.x
        //width: parent.width - x*2;
        //height: parent.height - y*2
        height: eaContainer.eaConstruction.menuDisplay.height

        //color: eaContainer.eaConstruction.menuDisplay.colour
        //color: menuItemDelegate.highlighted ? eaContainer.eaConstruction.menuDisplay.highlitedColour
        //                                    : eaContainer.eaConstruction.menuDisplay.colour
        color: eaContainer.eaConstruction.menuDisplay.colour

        border.color: eaContainer.eaConstruction.menuDisplay.borderColour
        border.width: eaContainer.eaConstruction.menuDisplay.borderWidth
        radius: eaContainer.eaConstruction.menuDisplay.radius
    }

    Text {
        id: itemText
        //width: parent.width; height: parent.height
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
/*
    Connections {
        target: menuListView
        onCurrentItemChanged: {
            console.log("menuListView onCurrentItemChanged");
            itemBackground.color = menuItemDelegate.highlighted
                    ? eaContainer.eaConstruction.menuDisplay.highlitedColour
                    : eaContainer.eaConstruction.menuDisplay.colour
        }
    }

    onClicked: {
        if (menuListView.currentIndex != index) {
            menuListView.currentIndex = index;
            stackCtl.currentIndex = position + stackCtl.startDrawerId
            titleLabel.text = model.title
        }
        listsDrawer.close();
    }

    Component.onCompleted: {
        setToolBarDisplayDataParameters(itemBackground
                     , itemText
                     , eaContainer.eaConstruction.menuDisplay
                     , menuItemDelegate);
    }

    function setMenuListDisplayParameters() {
        setToolBarDisplayDataParameters(itemBackground
                     , itemText
                     , eaContainer.eaConstruction.menuDisplay
                     , menuItemDelegate);
    }
*/
/*
    function setToolBarDisplayDataParameters(rectangle
                                          , textBox
                                          , displayData
                                          , delegate) {


        console.log("setMenuListdisplayDataParameters");
        rectangle.height = displayData.height

        rectangle.x = displayData.x
        rectangle.y = displayData.y
        rectangle.color = displayData.colour
        rectangle.color = delegate.highlighted
                ? displayData.highlitedColour
                : displayData.colour
        rectangle.border.color = displayData.borderColour
        rectangle.border.width = displayData.borderWidth
        rectangle.radius = displayData.radius

        textBox.font = displayData.font
        textBox.color = displayData.fontColour
        textBox.style = displayData.textStyle
        textBox.styleColor = displayData.styleColour

        textBox.x = displayData.xText
        textBox.y = displayData.yText
        textBox.verticalAlignment = displayData.vAlignment
        textBox.horizontalAlignment = displayData.hAlignment
        var it = rectangle;
        var itx = textBox;
        console.log("rectangle.border.color",rectangle.border.color);
    }


    function setMenuListDisplayParameters() {
        console.log("setMenuListDisplayParameters");

        itemBackground.x = eaContainer.eaConstruction.menuDisplay.x
        itemBackground.y = eaContainer.eaConstruction.menuDisplay.x
        //itemBackground.width = eaContainer.eaConstruction.menuDisplay.width;
        itemBackground.height = eaContainer.eaConstruction.menuDisplay.height
        itemBackground.color = eaContainer.eaConstruction.menuDisplay.colour
        itemBackground.color = menuItemDelegate.highlighted
                ? eaContainer.eaConstruction.menuDisplay.highlitedColour
                : eaContainer.eaConstruction.menuDisplay.colour
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
        var it = itemBackground;
        var itx = itemText;
        console.log("itemBackground.border.color",itemBackground.border.color);
    }
    */
}
