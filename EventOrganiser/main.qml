import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import Qt.labs.settings 1.0
import Qt.labs.platform 1.0
import QtQuick.Dialogs 1.2

import "content"
import "qrc:/shared"
import EventAppData 1.0

ApplicationWindow {
    id: appwin
    visible: true
    width: 1280;    height: 1024
    title: qsTr("Event App designer:\t" + eaContainer.eaInfo.eventName)
    property bool downloadFileOnly: true

    Connections {
        target: eaContainer.eaInfo
        onEventNameChanged: appwin.title = qsTr("Event App designer:\t")
                            + eaContainer.eaInfo.eventName
    }

    function setTitle() {
        appwin.title = qsTr("Event App designer:\t") + eaContainer.eaInfo.eventName
    }

    DlgDownloadEventUrl {
        id: dlgDownloadEventUrl
    }

    MenuBarEO {
        id: menuBarEO
    }

    header: HeaderTabBarForm {
        id: headerTabBar
    }

    EaContainerObj {
        id: eaContainer
    }

    RowLayout {
        width: 1100; height: 900;
        Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
        spacing: 10
        StackLayout {
            id: tabStack
            currentIndex: headerTabBar.currentIndex + 1
            //currentIndex: headerItem.headerTabBar.currentIndex
            anchors.fill: parent

            EAConstructionPage {
                visible: false
                id: constructionPage
                property alias eaConstruction: eaContainer.eaConstruction
                property alias dataFilename: eaContainer.dataFilename
                property alias firbaseUrl: eaContainer.firbaseUrl
            }

            EAListDisplayPage {
                id: eaListDisplayPage
                property alias dataFilename: eaContainer.dataFilename
                property alias featuredList: eaListDisplayPage.featuredList
            }

            DisplayTab {
                id: dispalyTab
            }

            Item {
                ColumnLayout {
                    Button {
                        height: 30
                        id: addItem
                        text: qsTr("Load Answers")
                        onPressed: {
                            eaContainer.loadAnswers();
                        }
                    }

                    Rectangle {
                        width: 800; height: 600
                        border.width : 0.5
                        border.color : "black"
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        Flickable {
                            anchors.fill: parent
                            TextArea.flickable: TextArea {
                                id: ansersTA
                                text: eaContainer.answers
                                wrapMode: TextArea.Wrap
                            }
                            ScrollBar.vertical: ScrollBar { }
                        }
                    } //Rectangle
                }
            }

        }
        Rectangle {
            id: dataBox
            width: 520; height: 720
            border.width : 0.5; border.color : "black"
            clip: true
            visible: tabStack.currentIndex === 1
                     || tabStack.currentIndex === 2 || tabStack.currentIndex === 0
            EventAppPage {
                x:10; y:10
                width: parent.width-20; height: parent.height-20
                id: ldpEventAppPage
            }
        } //Rectangle
    }
    Settings {
        category: "geometry"
        property alias x: appwin.x
        property alias y: appwin.y
        property alias width: appwin.width
        property alias height: appwin.height
    }

    Settings {
        id: settingsData
        category: "data"
        property alias dataFilename: eaContainer.dataFilename
        property alias firebaseUrl: eaContainer.firbaseUrl
        property alias databaseKey: eaContainer.eventKey
        property string style:  "default"
        //property alias style: eaContainer.eaConstruction.style
    }

    Component.onDestruction: {
        console.log("onDestruction.style", eaContainer.eaConstruction.style);
        settingsData.style = eaContainer.eaConstruction.style;
        console.log("onDestruction.style", settingsData.style);
    }

    Dialog {
        id: aboutDialogEO
        title:  eaContainer.eaConstruction.strings.mAbout

        Column {
            id: aboutColumn
            spacing: 20

            Label {
                width: aboutDialog.availableWidth
                text:  eaContainer.eaConstruction.strings.aboutText
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }

            Label {
                width: aboutDialog.availableWidth
                text: "Easy event app \n"
                      + "www.easyeventapp.co.uk\n"
                      + "Make easy event apps.\n"
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
        }
    }
}























