import QtQuick 2.0

ListDelegateForm {
    width: parent.width
    itemPresseed.color: "#11ffffff"
    //itemText.color: "green"
    //itemBackground.color: "#424246"
    //itemBackground.color: "blue"
    nextImage.source: "qrc:///shared/images/navigation_next_item.png"

    mouseArea.onClicked: {
        stackCtl.currentIndex = position + 2;
        console.log("mouseArea.onClicked position", position);
        //console.log("mouseArea onClicked count", count);
        console.log("mouseArea onClicked title", title);
        toolBar.titleLabel.text = model.title;
    }
}
