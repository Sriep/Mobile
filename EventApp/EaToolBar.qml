import QtQuick 2.7
import QtQuick.Controls 2.0
import "qrc:///shared/dataList.js" as DataListJS

EaToolBarForm {
    id: toolBar
    //titleLabel.text: eaContainer.eaInfo.eventName
    //userLable.text: eaContainer.user.loggodOn ? eaContainer.user.user : "logged off"
    drawerButton.onClicked:   listsDrawer.open()

    userBut.onClicked: {
        stackCtl.currentIndex = stackCtl.userLoginId;
    }

    //menuButton.onClicked: optionsMenu.open()
    menuButton.onClicked: optionsDrawer.open()

    Connections {
        target: eaContainer //(eaConstruction)
        onEaConstructionChanged: {
            setToolBarDisplayDataParameters(
                        toolBar.itemBackground
                        , toolBar.titleLabel
                        , toolBar);
        }
    }
/*
    Component.onCompleted: {
        setToolBarDisplayDataParameters(
                    toolBar.itemBackground
                    , toolBar.titleLabel
                    , toolBar)
    }
*/
    ListsDrawer {
        id: listsDrawer
    }

    OptionsDrawer {
        id: optionsDrawer
    }     

    function setMenuDisplayDataParameters(rectangle
                                          , image
                                          , textBox
                                          , displayData
                                          , delegate) {
        DataListJS.setBackgroundDisplayParameters(rectangle, displayData, delegate);
        DataListJS.setTextBoxDisplayParameters(textBox , displayData);
        DataListJS.setImageDisplyaParameters(image, displayData)
    }

    function setToolBarDisplayDataParameters(rectangle
                                          , textBox
                                          , displayData
                                          , delegate) {
        DataListJS.setBackgroundDisplayParameters(rectangle, displayData, delegate);     
        DataListJS.setTextBoxDisplayParameters(textBox , displayData);
        //DataListJS.setImageDisplyaParameters(image, displayData)
        toolBar.drawerButton.source = eaContainer.eaConstruction.toolBarDisplay.whiteIcons
                ? "qrc:///shared/images/drawerW@4x.png"
                : "qrc:///shared/images/drawer@4x.png";
        toolBar.userBut.source = eaContainer.eaConstruction.toolBarDisplay.whiteIcons
                ? "qrc:///shared/images/user-shape_32White.png"
                : "qrc:///shared/images/user-shape_32.png";
    }

    function setOptionsMenuDisplayParamters(rectangle
                                            , image
                                            , textBox
                                            , displayData
                                            , delegate) {
        image.visible = false;
        image.width = 0;
        DataListJS.setBackgroundDisplayParameters(rectangle, displayData, delegate);
        DataListJS.setTextBoxDisplayParameters(textBox , displayData);
        textBox.x = 10
    }
}
/*
    function setBackgroundDisplayParameters(rectangle
                                           , displayData
                                           , delegate)   {
        rectangle.height = displayData.height

        rectangle.x = displayData.x
        rectangle.y = displayData.y
        rectangle.color = displayData.colour
        rectangle.color = delegate.highlighted
                ? displayData.highlitedColour
                : displayData.colour
        rectangle.border.color = displayData.borderColour
        rectangle.border.width = displayData.borderWidth
        rectangle.radius = displayData.radius
    }

    function setImageDisplyaParameters(image, displayData, delegate) {
        image.height = displayData.imageHeight;
        image.width = displayData.imageWidth;
        image.x = displayData.xImage;
        image.y = displayData.yText;
    }

    function setTextBoxDisplayParameters(textBox
                                         , displayData
                                         , delegate) {
        textBox.font = displayData.font
        textBox.color = displayData.fontColour
        textBox.style = displayData.textStyle
        textBox.styleColor = displayData.styleColour

        textBox.x = displayData.xText
        textBox.y = displayData.yText
        textBox.verticalAlignment = displayData.vAlignment
        textBox.horizontalAlignment = displayData.hAlignment
    }
}

*/









































