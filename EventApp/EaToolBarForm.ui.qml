import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4


ToolBar {
    id: toolBar
    property alias drawerButton: drawerButton
    property alias menuButton: menuButton
    property alias titleLabel: titleLabel
    property alias userBut: userBut
    property alias userLable: userLable
    property alias eventIconButton: eventIconButton
    property alias eventIconImage: eventIconImage
    property alias itemBackground: itemBackground
    Rectangle {
        id: itemBackground
        x: eaContainer.eaConstruction.toolBarDisplay.x
        y: eaContainer.eaConstruction.toolBarDisplay.x
        width: parent.width - x*2;
        height: parent.height - y*2
        color: eaContainer.eaConstruction.toolBarDisplay.colour
        border.color: eaContainer.eaConstruction.toolBarDisplay.borderColour
        border.width: eaContainer.eaConstruction.toolBarDisplay.borderWidth
        radius: eaContainer.eaConstruction.toolBarDisplay.radius
    }

    RowLayout {
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        spacing: 20
        anchors.fill: parent
        clip: true
        ToolButton {
            id: drawerButton
            contentItem: Image {
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source:  eaContainer.eaConstruction.toolBarDisplay.whiteIcons
                         ? "qrc:///shared/images/drawerW@4x.png"
                         : "qrc:///shared/images/drawer@4x.png"
            }
        }

        ToolButton {
            id: eventIconButton
            y:0
            contentItem: Image {
                id: eventIconImage
                fillMode: Image.Pad
                source:  "image://listIcons_" + eaContainer.imageVersion + "/-1"
                visible: eaContainer.showEventIcon
            }
        }

        Label {
            id: titleLabel

            text: eaContainer.eaInfo.eventName
            //text: eventIconImage.height

            elide: Label.ElideRight
            Layout.fillWidth: true

            font: eaContainer.eaConstruction.toolBarDisplay.font
            color: eaContainer.eaConstruction.toolBarDisplay.fontColour
            style: eaContainer.eaConstruction.toolBarDisplay.textStyle
            styleColor: eaContainer.eaConstruction.toolBarDisplay.styleColour
            x: eaContainer.eaConstruction.toolBarDisplay.xText
            y: eaContainer.eaConstruction.toolBarDisplay.yText
            //verticalAlignment: eaContainer.eaConstruction.toolBarDisplay.vAlignment
            //horizontalAlignment: eaContainer.eaConstruction.toolBarDisplay.hAlignment
        }

        ToolButton {
            visible: !downloadFileOnly
            id: userBut
            contentItem: Image {
                width: 20
                height: 20
                fillMode: Image.Pad
                //horizontalAlignment: Image.AlignHCenter
                //verticalAlignment: Image.AlignVCenter
                source:  eaContainer.eaConstruction.toolBarDisplay.whiteIcons
                           ? "qrc:///shared/images/user-shape_24white.png"
                           : "qrc:///shared/images/user-shape_24.png"
            }
        }

        Label {
            visible: !downloadFileOnly
            id: userLable
            //text: "logged off"
            text:  eaContainer.user.loggedOn ? eaContainer.user.user : "logged off"
            font.family: eaContainer.eaConstruction.toolBarDisplay.font.family
            color: eaContainer.eaConstruction.toolBarDisplay.fontColour
            style: eaContainer.eaConstruction.toolBarDisplay.textStyle
            styleColor: eaContainer.eaConstruction.toolBarDisplay.styleColour
            font.pixelSize: 8
            elide: Label.ElideRight
            Connections {
                target: eaContainer.user
                onLoggedOnChanged: userLable.text =  eaContainer.user.loggedOn
                            ? eaContainer.user.user
                            : eaContainer.eaConstruction.strings.tbLoggedOff
            }
            Connections {
                target: eaContainer.eaConstruction.strings
                onTbLoggedOffChanged: userLable.text =  eaContainer.user.loggedOn
                                ? eaContainer.user.user
                                : eaContainer.eaConstruction.strings.tbLoggedOff

            }
        }

        ToolButton {
            id: menuButton
            contentItem: Image {
                fillMode: Image.Pad
                //horizontalAlignment: Image.AlignHCenter
                //verticalAlignment: Image.AlignVCenter
                source:  eaContainer.eaConstruction.toolBarDisplay.whiteIcons
                            ? "qrc:///shared/images/menuW@4x.png"
                            : "qrc:///shared/images/menu@4x.png"
            }

        }
    }

}

