
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import "content"
import "qrc:/shared"
import EventAppData 1.0

ApplicationWindow {
    id: appwin
    visible: true
    //width: 600; height: 400
    //width: 800; height: 600
    width: 1280;    height: 1024
    title: qsTr("Event App designer:\t" + eaContainer.eaInfo.eventName)

    header: HeaderTabBarForm {
        id: headerTabBar
    }

    EaContainerObj {
        id: eaContainer
    }

    HttpDownload {
        id: httpDownload
        onFinishedDownload: {
            console.log("Download finished");
            var fileName = httpDownload.fileDownloaded;
            console.log("About to call loadNewEventApp", fileName);
            eaContainer.installNewEvent(fileName);
        }
    }

    StackLayout {
        id: tabStack
        currentIndex: headerTabBar.currentIndex
        anchors.fill: parent

        //WelcomeTab {}

        EAConstructionPage {
            property alias eaConstruction: eaContainer.eaConstruction
            property alias dataFilename: eaContainer.dataFilename
            property alias firbaseUrl: eaContainer.firbaseUrl
        }

        EAInfoPage {
            property alias eventInfo: eaContainer.eaInfo
            property alias dataFilename: eaContainer.dataFilename
        }

        EAListDisplayPage {
            id: eaListDisplayPage
            property alias dataFilename: eaContainer.dataFilename
            property alias featuredList: eaListDisplayPage.featuredList
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
}























