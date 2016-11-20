import QtQuick 2.0

ListDelegateForm {
    itemPresseed.color: "#11ffffff"
    itemText.color: "white"
    itemBackground.color: "#424246"
    nextImage.source: "../images/navigation_next_item.png"

    mouseArea.onClicked: topDelegate.clicked()
}
