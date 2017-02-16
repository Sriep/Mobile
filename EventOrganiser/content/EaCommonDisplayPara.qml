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
    Connections {
        target: applyBut
        onPressed: {
            console.log("style box text", styleBox.displayText);
            eaContainer.eaConstruction.style = styleBox.displayText;
        }
    }

    Connections {
        target: newFormat
        onPressed: {
            loadStoredDispaly(displayList.currentIndex );
        }
    }

    Connections {
        target: displayList
        Component.onCompleted: {
            popDisplayList()
        }
    }

    function popDisplayList() {
        console.log("Start popDisplayList");
        var displays = eaContainer.listDisplayFormats().split(".json");
        displaysModel.clear();
        var itemCount = displays.length;
        for ( var i=0 ; i<itemCount ; i++ ) {
            if (displays[i].length > 0)
                displaysModel.append({"displayName": displays[i]});
        }
    }

    function loadStoredDispaly (index) {
        var filename = ":/shared/displays/";
        filename += displaysModel.get(index).displayName;
        filename += ".json";
        eaContainer.loadDisplayResource(filename);
    }

    mouseAreaLV.onClicked: {
        var index = displayList.indexAt(mouse.x, mouse.y);
        if (index >= 0) {
            displayList.currentIndex = index;
        }
    }

    mouseAreaLV.onDoubleClicked: {
        var index = displayList.indexAt(mouse.x, mouse.y);
        if (index >= 0) {
            displayList.currentIndex = index;
            loadStoredDispaly(index);
        }
    }
}






















































































