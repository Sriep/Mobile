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
    property alias evnetIconImage: evnetIconImage
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
            //visible: eaContainer.showEventIcon
            //z:5
            contentItem: Image {
                id: evnetIconImage
                //z:5
                //fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                //downloadFileOnly
                //fillMode: Image.PreserveAspectFit
                fillMode: Image.Pad
                source:  "image://listIcons_" + eaContainer.imageVersion + "/-1"
                //source:  "qrc:///shared/images/user-shape_32White.png"
                //source: "qrc:///shared/images/user-shape_32.png"
            }
        }

        Label {
            id: titleLabel

            text: eaContainer.eaInfo.eventName
            //text: evnetIconImage.height

            elide: Label.ElideRight
            Layout.fillWidth: true

            font: eaContainer.eaConstruction.toolBarDisplay.font
            color: eaContainer.eaConstruction.toolBarDisplay.fontColour
            style: eaContainer.eaConstruction.toolBarDisplay.textStyle
            styleColor: eaContainer.eaConstruction.toolBarDisplay.styleColour
            x: eaContainer.eaConstruction.toolBarDisplay.xText
            y: eaContainer.eaConstruction.toolBarDisplay.yText
            verticalAlignment: eaContainer.eaConstruction.toolBarDisplay.vAlignment
            horizontalAlignment: eaContainer.eaConstruction.toolBarDisplay.hAlignment
        }

        ToolButton {
            id: userBut
            contentItem: Image {
                width: 20
                height: 20
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source:  eaContainer.eaConstruction.toolBarDisplay.whiteIcons
                           ? "qrc:///shared/images/user-shape_32White.png"
                           : "qrc:///shared/images/user-shape_32.png"
            }
        }

        Label {
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
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source:  eaContainer.eaConstruction.toolBarDisplay.whiteIcons
                            ? "qrc:///shared/images/menuW@4x.png"
                            : "qrc:///shared/images/menu@4x.png"
            }

        }
    }

}

