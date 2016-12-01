
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
        eaSpeakers: EAItemList {
            listName: "speakers"
        }
    }

    StackLayout {
        id: tabStack
        currentIndex: headerTabBar.currentIndex
        anchors.fill: parent

        WelcomeTab {}

        EAConstructionPage {
            property alias eaConstruction: eaContainer.eaConstruction
            property alias dataFilename: eaContainer.dataFilename
        }

        EAInfoPage {
            property alias eventInfo: eaContainer.eaInfo
            property alias dataFilename: eaContainer.dataFilename
        }

        EASelectList {}

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























