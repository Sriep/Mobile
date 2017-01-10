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
        }
    }

    hAlignCombo.currentIndex: Math.round(Math.log(featuredDisplay.hAlignment)/Math.LN2);
    vAlignCombo.currentIndex: Math.round(Math.log(featuredDisplay.vAlignment)/Math.LN2 - 5);

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



