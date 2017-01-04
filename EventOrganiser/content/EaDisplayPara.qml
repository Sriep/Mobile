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
            //featuredDisplay.x = xTF.text;
            featuredDisplay.x = xTF.value;
            featuredDisplay.y = yTF.value;
            //featuredDisplay.width = widthTF.text
            featuredDisplay.height = heightTF.value;
            featuredDisplay.borderWidth = borderWidthSB.value;
            featuredDisplay.radius = radiusTF.value;
            featuredDisplay.textStyle = styleCombo.currentIndex;
            featuredDisplay.styleColour = styleColourDlg.currentColor;

            console.log("style box text", styleBox.displayText);
            //settingsData.style = styleBox.displayText;
            eaContainer.eaConstruction.style = styleBox.displayText;
        }
    }

    Connections {
        target: fontDlg
        onAccepted: {
            var colour;
            fontDlg.updateFont(featuredDisplay.font, colour);
            featuredDisplay.fontColour = fontDlg.getFontColour();
        }
    }
    Connections {
        target: fontDlg
        onOpened: {
            fontDlg.populateForm(featuredDisplay.font
                                , featuredDisplay.fontColour);
        }
    }


}



