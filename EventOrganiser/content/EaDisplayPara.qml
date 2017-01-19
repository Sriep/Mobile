import QtQuick 2.0

EaDisplayParaForm {
    width: parent.width; height: parent.height
    //property alias title: title
    //property var featuredDisplay: eaContainer.eaConstruction.display
    groupDispalyPara.title: title;

    Connections {
        target: applyBut
        onPressed: {
            featuredDisplay.x = xTF.value;
            featuredDisplay.y = yTF.value;
            //featuredDisplay.width = widthTF.text
            featuredDisplay.height = heightTF.value;
            featuredDisplay.borderWidth = borderWidthSB.value;
            featuredDisplay.radius = radiusTF.value;
            featuredDisplay.textStyle = styleCombo.currentIndex;
            featuredDisplay.styleColour = styleColourDlg.currentColor;
            featuredDisplay.xText = dxTextSB.value;
            featuredDisplay.yText = dyTextSB.value;

            console.log("hAlignment", hAlignCombo.currentIndex);
            console.log("vAlignment", vAlignCombo.currentIndex);
            console.log("pow hAlignment", Math.pow(2,hAlignCombo.currentIndex));
            console.log("pow vAlignment", Math.pow(2,vAlignCombo.currentIndex+5));

            featuredDisplay.hAlignment = Math.pow(2,hAlignCombo.currentIndex);
            featuredDisplay.vAlignment = Math.pow(2,vAlignCombo.currentIndex+5);

            console.log("after hAlignment", featuredDisplay.hAlignment);
            console.log("after vAlignment", featuredDisplay.vAlignment);
            console.log("after hAlignment", Math.log(featuredDisplay.hAlignment)/Math.LN2);
            console.log("after vAlignment", Math.log(featuredDisplay.vAlignment)/Math.LN2-4);
            fontDlg.updateFont(featuredDisplay.font);
            featuredDisplay.fontColour = fontDlg.getFontColour();
            eaContainer.eaConstructionChanged(eaContainer.eaConstruction);            
        }
    }

    hAlignCombo.currentIndex: Math.round(Math.log(featuredDisplay.hAlignment)/Math.LN2);
    vAlignCombo.currentIndex: Math.round(Math.log(featuredDisplay.vAlignment)/Math.LN2 - 5);

    Connections {
        target: fontDlg
        onAccepted: {
            fontDlg.updateFont(featuredDisplay.font);
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

    Connections {
        target: eaContainer //(eaConstruction)
        onEaConstructionChanged: {
            console.log("eaContainer onDisplayChanged");
            xTF.value = featuredDisplay.x;
            yTF.value = featuredDisplay.y;
            heightTF.value = featuredDisplay.height;
            borderWidthSB.value = featuredDisplay.width;
            radiusTF.value = featuredDisplay.radius;
            styleCombo.currentIndex = featuredDisplay.textStyle;
            styleColourDlg.currentColor = featuredDisplay.styleColour;
            dxTextSB.value = featuredDisplay.xText;
            dyTextSB.value = featuredDisplay.yText;
            hAlignCombo.currentIndex = Math.round(Math.log(featuredDisplay.hAlignment)/Math.LN2);
            vAlignCombo.currentIndex = Math.round(Math.log(featuredDisplay.vAlignment)/Math.LN2 - 5);
            fontDlg.populateForm(featuredDisplay.font, featuredDisplay.fontColour);
        }
    }
    /*
        rectangle.x = featuredDisplay.x
        rectangle.y = featuredDisplay.y
        rectangle.color = featuredDisplay.colour
        rectangle.border.color = featuredDisplay.borderColour
        rectangle.border.width = featuredDisplay.borderWidth
        rectangle.radius = featuredDisplay.radius

        textBox.font = featuredDisplay.font
        textBox.color = featuredDisplay.fontColour
        textBox.style = featuredDisplay.textStyle
        textBox.styleColor = featuredDisplay.styleColour
        */
}



