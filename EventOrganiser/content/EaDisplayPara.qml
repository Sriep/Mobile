import QtQuick 2.0
import "qrc:///shared/dataList.js" as DLjs

EaDisplayParaForm {
    width: parent.width; height: parent.height
    groupDispalyPara.title: title;

    Component.onCompleted: {
        //paraToolBarHovers();
    }

    function paraToolBarHovers() {
        console.log("EaDisplayPara.onCompleted");
        DLjs.addTT(paraToolBar.styleCombo, "Border width in pixels.");
        DLjs.addTT(paraToolBar.styleColourBut, "Border width in pixels.");
        DLjs.addTT(paraToolBar.dxTextSB, "Border width in pixels.");
        DLjs.addTT(paraToolBar.dyTextSB, "Border width in pixels.");
        DLjs.addTT(paraToolBar.hAlignCombo, "Border width in pixels.");
        DLjs.addTT(paraToolBar.vAlignCombo, "Border width in pixels.");
        DLjs.addTT(paraToolBar.bkColourBut, "Border width in pixels.");
        DLjs.addTT(paraToolBar.xTF, "Border width in pixels.");
        DLjs.addTT(paraToolBar.yTF, "Border width in pixels.");
        DLjs.addTT(paraToolBar.heightTF, "Border width in pixels.");
        DLjs.addTT(paraToolBar.radiusTF, "Border width in pixels.");
        DLjs.addTT(paraToolBar.borderWidthSB, "Border width in pixels.");
        DLjs.addTT(paraToolBar.whiteIconsCB, "Border width in pixels.");
        DLjs.addTT(paraToolBar.applyBut, "Border width in pixels.");
    }
/*
    Connections {
        target: bkColourBut
        onCompleted: {
            DLjs.addTT(paraToolBar.bkColourBut, "Border width in pixels.");
        }
    }
*/
    Connections {
        target: applyBut
        onPressed: {
            featuredDisplay.x = xTF.value;
            featuredDisplay.y = yTF.value;
            //heightSB.value;
            //featuredDisplay.width = widthTF.text
            featuredDisplay.height = heightTF.value;
            featuredDisplay.borderWidth = borderWidthSB.value;
            featuredDisplay.radius = radiusTF.value;
            featuredDisplay.textStyle = styleCombo.currentIndex;
            featuredDisplay.styleColour = styleColourDlg.currentColor;
            featuredDisplay.xText = dxTextSB.value;
            featuredDisplay.yText = dyTextSB.value;
            featuredDisplay.whiteIcons = whiteIconsCB.checked;

            featuredDisplay.imageHeight = heightImageSB.value;
            featuredDisplay.xImage = xImageSB.value;
            featuredDisplay.yImage = yImageSB.value;

            //featuredDisplay.hAlignment = Math.pow(2,hAlignCombo.currentIndex);
            //featuredDisplay.vAlignment = Math.pow(2,vAlignCombo.currentIndex+5);

            console.log("after hAlignment", featuredDisplay.hAlignment);
            console.log("after vAlignment", featuredDisplay.vAlignment);
            console.log("after hAlignment", Math.log(featuredDisplay.hAlignment)/Math.LN2);
            console.log("after vAlignment", Math.log(featuredDisplay.vAlignment)/Math.LN2-4);
            fontDlg.updateFont(featuredDisplay.font);
            featuredDisplay.fontColour = fontDlg.getFontColour();
            eaContainer.eaConstructionChanged(eaContainer.eaConstruction);            
        }
    }

    //hAlignCombo.currentIndex: Math.round(Math.log(featuredDisplay.hAlignment)/Math.LN2);
    //vAlignCombo.currentIndex: Math.round(Math.log(featuredDisplay.vAlignment)/Math.LN2 - 5);

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
            heightImageSB.value = featuredDisplay.imageHeight;
            xImageSB.value = featuredDisplay.xImage;
            yImageSB.value = featuredDisplay.yImage;
            console.log("eaContainer onDisplayChanged");
            xTF.value = featuredDisplay.x;
            yTF.value = featuredDisplay.y;
            heightTF.value = featuredDisplay.height;
            borderWidthSB.value = featuredDisplay.borderWidth;
            radiusTF.value = featuredDisplay.radius;
            styleCombo.currentIndex = featuredDisplay.textStyle;
            styleColourDlg.currentColor = featuredDisplay.styleColour;
            dxTextSB.value = featuredDisplay.xText;
            dyTextSB.value = featuredDisplay.yText;
            whiteIconsCB.checked = featuredDisplay.whiteIcons;
            //hAlignCombo.currentIndex = Math.round(Math.log(featuredDisplay.hAlignment)/Math.LN2);
            //vAlignCombo.currentIndex = Math.round(Math.log(featuredDisplay.vAlignment)/Math.LN2 - 5);
            fontDlg.populateForm(featuredDisplay.font, featuredDisplay.fontColour);
        }
    }



}



