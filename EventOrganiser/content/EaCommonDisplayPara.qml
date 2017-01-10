import QtQuick 2.0

EaCommonDisplayParaForm {

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
            console.log("style box text", styleBox.displayText);
            eaContainer.eaConstruction.style = styleBox.displayText;
        }
    }
/*
    rectangle1.color: eaContainer.eaConstruction.backColour
    colourLabel1.text: qsTr("Background colour: ")
                       + eaContainer.eaConstruction.backColour;
    mouseArea1.onClicked:  {
        colorDialog.index = 0;
        colorDialog.title = qsTr("Select background colour for app");
        colorDialog.color = eaContainer.eaConstruction.backColour;
        colorDialog.open()
    }
    mouseArea2.onClicked:  {
        colorDialog.index = 1;
        colorDialog.title = qsTr("Select foregroud colour for app");
        colorDialog.color = eaContainer.eaConstruction.foreColour;
        colorDialog.open()
        eaContainer.eaConstruction.foreColour = colorDialog.color;
    }
*/
}
