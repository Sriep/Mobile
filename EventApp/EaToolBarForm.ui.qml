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

        Label {
            id: titleLabel
            text: eaContainer.eaInfo.eventName
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

