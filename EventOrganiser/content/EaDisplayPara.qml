import QtQuick 2.0

EaDisplayParaForm {
    width: parent.width; height: parent.height
    property var featuredDisplay: eaContainer.eaConstruction.display

    function setStyleCombo() {
        var styleText = eaContainer.eaConstruction.style;
        var styleIndex = styleBox.find(styleText, Qt.MatchExactly)
        if (styleIndex !== -1) {
            styleBox.currentIndex = styleIndex
        }
    }

    Connections {
        target: eaContainer.eaConstruction
        onStyleChanged: {
            setStyleCombo();
        }
    }
    Connections {
        target: eaContainer
        onEaItemListsChanged: {
            setStyleCombo();
        }
    }


    Connections {
        target: applyBut
        onPressed: {
            featuredDisplay.x = xTF.text;
            featuredDisplay.y = yTF.text
            featuredDisplay.width = widthTF.text
            featuredDisplay.height = heightTF.text
            featuredDisplay.radius = radiusTF.text

            console.log("style box text", styleBox.displayText);
            //settingsData.style = styleBox.displayText;
            eaContainer.eaConstruction.style = styleBox.displayText;
        }
    }

}



