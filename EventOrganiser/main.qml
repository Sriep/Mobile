
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import "content"
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

    EAContainer {
        id: eaContainer
        //property alias saSpeakersList: eaListModel;
        eaConstruction: EAConstruction {
        }
        eaInfo: EAInfo {
        }
        eaSpeakers: EAItemList {
            listName: "speakers"
        }

        Component.onCompleted: {
            console.log("Componet completed: ", eaContainer.dataFile);
            console.log("Settins filename: ", settingsData.dataFilename);
            dataFilename = settingsData.dataFilename;
            loadEventApp();
            console.log("Data file: ", dataFilename);
            console.log("back colour: ", eaConstruction.backColour);
            console.log("fore colour: ", eaConstruction.foreColour);
            console.log("font colour: ", eaConstruction.textColour);
            console.log("event name: ", eaInfo.eventName);
        }

        Component.onDestruction: {
            console.log("Settins filename before: ", settingsData.dataFilename);
            settingsData.dataFilename = dataFilename;
            console.log("Settins filename after: ", settingsData.dataFilename);
        }

    }

   /* MainStack {
        id: mainStack
        property alias mainContainer: eaContainer
    }
*/
    StackLayout {
        id: tabStack
        currentIndex: headerTabBar.currentIndex
        anchors.fill: parent

        WelcomeTab {
        }

        EAConstructionPage {
            property alias eaConstruction: eaContainer.eaConstruction
            property alias dataFilename: eaContainer.dataFilename
        }

        EAInfoPage {
            property alias eventInfo: eaContainer.eaInfo
            property alias dataFilename: eaContainer.dataFilename
        }

        Rectangle {
            color: 'plum'
            implicitWidth: 300
            implicitHeight: 200
        }
        EAListDisplayPage {
            property alias eventSpeakers: eaContainer.eaSpeakers
            property alias dataFilename: eaContainer.dataFilename          
        }
        Rectangle {
            color: 'brown'
            implicitWidth: 200
            implicitHeight: 200
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
    }
}























