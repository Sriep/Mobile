import QtQuick 2.0

ListDelegateForm {
    width: parent.width
    itemPresseed.color: "#11ffffff"
    itemText.color: "green"
    itemBackground.color: "#424246"
    nextImage.source: "../images/navigation_next_item.png"

   // mouseArea.onClicked: topDelegate.clicked()
    //drawerDelegate.onClicked: stackView.push(Qt.resolvedUrl(page))
    mouseArea.onClicked: mainStack.push(Qt.resolvedUrl(drawerModel.page))

}
