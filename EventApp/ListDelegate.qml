import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qrc:///shared/dataList.js" as DataListJS
import EventAppData 1.0


 //setDisplayParameters(displayData, rectangle, textBox)
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
/*
    Connections {
        target: eaContainer.eaConstruction.display
        //target: eaContainer
       onDisplayParamtersChanged: {
        //onEaConstructionChanged: {
        // onEaInfoChanged: {
            DataListJS.setDisplayParameters(eaContainer.eaConstruction.display
                                            , itemBackground, i
                                                temText);
        }
    }

    function setDispalyParameters () {
        DataListJS.setDisplayParameters(eaContainer.eaConstruction.display
                                        , itemBackground
                                        , itemText);
    }
*/
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

    Connections {
        target: eaDisplay
        onHeightChanged: {
            itemBackground.heigth = eaDisplay.heigth
        }
    }

}
