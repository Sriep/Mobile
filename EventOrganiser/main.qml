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
    property bool downloadFileOnly: false

    Connections {
        target: eaContainer.eaInfo
        onEventNameChanged: appwin.title = qsTr(" Event App designer: \t")
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

    MouseArea {
        id: appMouseArea
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: mainContextMenu.open()
    }

    Menu {
        id: mainContextMenu
        MenuItem {
          text: qsTr("&New")
          onTriggered: eaContainer.clearEvent();
        }
        MenuItem {
          text: qsTr("&Load")
          onTriggered: constructionPage.loadFileDialog.open()
        }
        MenuItem {
          text: qsTr("&Downlaod from url")
          onTriggered: dlgDownloadEventUrl.open()
        }
        MenuItem {
          text: qsTr("&Save As...")
          onTriggered: constructionPage.saveFileDialog.open()
        }
        MenuItem {
          text: qsTr("&Refresh")
          onTriggered: eaContainer.refreshData()
        }
        MenuItem {
          text: qsTr("&Quit")
          onTriggered: Qt.quit()
        }

        MenuSeparator {}

        MenuItem {
          text: qsTr("&Load display")
          onTriggered: loadDisplayDialog2.open()
        }
        MenuItem {
          text: qsTr("&Save display As...")
          onTriggered: saveDispalyDialog2.open()
        }

        MenuSeparator {}

        MenuItem {
          text: qsTr("&Assistant")
          onTriggered: eaAssistant.startAssistant("index.html");
        }
        MenuItem {
          text: qsTr("&About")
          onTriggered: aboutDialogEO.open()
        }
    }

    /*Component.onCompleted: {
        console.log("onCompleted");
        mainContextMenu.addMenu(menuBarEO.fileMenu);
        mainContextMenu.addMenu(menuBarEO.dispalyMenu);
        mainContextMenu.addMenu(menuBarEO.helpMenu);
    }*/

    header: HeaderTabBarForm {
        id: headerTabBar
    }

    EaContainerObj {
        id: eaContainer
    }

    Assistant { id: eaAssistant }

    RowLayout {
        y: 30
        width: 1100; height: 900;
        //Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        spacing: 10
        StackLayout {
            id: tabStack
            currentIndex: headerTabBar.currentIndex //+ 1
            //currentIndex: headerItem.headerTabBar.currentIndex
            anchors.fill: parent

            EAConstructionPage {
                visible: true
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
            //width: 520; height: 900
            border.width : 0.5; border.color : "black"
            clip: true
            Layout.alignment: Qt.AlignTop
            //y: 20
            visible: tabStack.currentIndex === 1
                     || tabStack.currentIndex === 2
                     || tabStack.currentIndex === 0
            EventAppPage {
                x:10; y:10
                width: parent.width-20; height: parent.height-20
                id: ldpEventAppPage
            }

        } //Rectangle
    } // RowLayout
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
       // property alias displayName: eaContainer.eaConstruction.displayName
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
/*
            Label {
                width: aboutDialogEO.availableWidth
                text:  eaContainer.eaConstruction.strings.aboutText
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
*/
            Label {
                width: aboutDialogEO.availableWidth
                text: "<html><h2>Event App Orginser</h2><br>"
                      + "<a href=\"http://www.easyeventapps.com\">www.easyeventapps.com</a><br>"
                      + "Version " + eaContainer.appVersion() + "</html>\n"
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
        }
    }
}























