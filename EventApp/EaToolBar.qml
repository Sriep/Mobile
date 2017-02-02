import QtQuick 2.7
import QtQuick.Controls 2.0

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

/*

    Menu {
        id: optionsMenu
        x: parent.width - width
        transformOrigin: Menu.TopRight
        MenuItem {
            text: qsTr("Login")
            onTriggered: stackCtl.currentIndex = stackCtl.userLoginId;
            visible: !eaContainer.isEventStatic
        }
        MenuItem {
            id: menuItemLoadEventKey
            text: qsTr("Load from Key")
            onTriggered: stackCtl.currentIndex = stackCtl.loadEventKey;
        }
        MenuItem {
            id: menuItemLoadEventFile
            text: qsTr("Load from file")
            onTriggered: stackCtl.currentIndex = stackCtl.loadEventFile;
        }
        MenuItem {
            id: menuItemLoadEventFB
            text: qsTr("Load from Firebase")
            onTriggered: stackCtl.currentIndex = stackCtl.loadEventFB;
        }
        MenuItem {
            text: qsTr("About")
            onTriggered: aboutDialog.open()
        }
        MenuItem {
            text: qsTr("Exit")
            onTriggered: Qt.quit()
        }
    }
*/
    ListsDrawer {
        id: listsDrawer
    }

    OptionsDrawer {
        id: optionsDrawer
    }



    function setToolBarDisplayDataParameters(rectangle
                                          , textBox
                                          , displayData
                                          , delegate) {
        setRectangleDisplayParameters(rectangle, displayData, delegate);
        setTextBoxDisplayParameters(textBox , displayData, delegate);
    }

    function setRectangleDisplayParameters(rectangle
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











































