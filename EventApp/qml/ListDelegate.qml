import QtQuick 2.0

ListDelegateForm {
    width: parent.width
    itemPresseed.color: "#11ffffff"
    itemText.color: "green"
    itemBackground.color: "#424246"
    nextImage.source: "../images/navigation_next_item.png"

   // mouseArea.onClicked: topDelegate.clicked()
    //drawerDelegate.onClicked: stackView.push(Qt.resolvedUrl(page))
    //mouseArea.onClicked: stackCtl.push(Qt.resolvedUrl(drawerModel.page))

    mouseArea.onClicked: {
        console.log("mouseArea.onClicked tack countrol count: ", stackCtl.count);
        console.log("stack control current index: ", stackCtl.currentIndex);
        console.log("drawerView.currentIdnex: ", drawerView.currentIndex);
        stackCtl.currentIndex = drawerView.currentIndex + 2;
        console.log("stack countrol count: ", stackCtl.count);
        console.log("stack control current index: ", stackCtl.currentIndex);
    }
}
