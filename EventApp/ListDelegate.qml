import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import EventAppData 1.0

ListDelegateForm {
    width: parent.width
    property EAObjDisplay eaDisplay: eaContainer.eaConstruction.display

    itemPresseed.color: "#11ffffff"
    //itemText.color: "green"
    //itemBackground.color: "#424246"
    //itemBackground.color: "blue"
    nextImage.source: "qrc:///shared/images/navigation_next_item.png"

    mouseArea.onClicked: {
        stackCtl.currentIndex = position + stackCtl.startDrawerId
        console.log("mouseArea.onClicked position", position);
        var sc = stackCtl;
        console.log("mouseArea onClicked title", title);
        toolBar.titleLabel.text = model.title;
    }    

    Connections {
        target: eaDisplay
        onXChanged: {
            itemBackground.x = eaDisplay.x
        }
    }
    Connections {
        target: eaDisplay
        onYChanged: {
            itemBackground.y = eaDisplay.y
        }
    }
    Connections {
        target: eaDisplay
        onRadiusChanged: {
            itemBackground.radius = eaDisplay.radius
        }
    }
/*
    Connections {
        target: eaDisplay
        onWidthChanged: {
            drawerDelegate.width = eaDisplay.width
        }
    }*/
    Connections {
        target: eaDisplay
        onHeightChanged: {
            drawerDelegate.heigth = eaDisplay.heigth
        }
    }

}
