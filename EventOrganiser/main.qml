//import QtQuick 2.7
//import QtQuick.Controls 2.0
//import QtQuick.Layouts 1.1
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
//import QtQuick.Controls.Material 2.0
//import QtQuick.Controls.Universal 2.0
import Qt.labs.settings 1.0
import EventAppData 1.0

ApplicationWindow {
    id: appwin
    visible: true
    //width: 600; height: 400
    //width: 800; height: 600
    width: 1280;    height: 1024
    title: qsTr("Event App designer:\t" + eaContainer.eaInfo.eventName)

    header: TabBar {
        id: headerTabBar
        Layout.minimumWidth: 360
        Layout.minimumHeight: 360
        Layout.preferredWidth: 480
        Layout.preferredHeight: 640
        TabButton {
            text: qsTr("Construction")
        }
        TabButton {
            text: qsTr("Event")
        }
        TabButton {
            text: qsTr("Program")
        }
        TabButton {
            text: qsTr("Speakers")
        }
        TabButton {
            text: qsTr("Delegates")
        }
    }

    EAContainer {
        id: eaContainer
        //dataFilename: dataFilename
        eaConstruction: EAConstruction {}
        eaInfo: EAInfo {}
    }

    StackLayout {
        id: view
        currentIndex: headerTabBar.currentIndex
        anchors.fill: parent

        EAConstructionPage {
            property alias eaContainer: eaContainer
            property alias eaConstruction: eaContainer.eaConstruction
            property alias dataFilename: eaContainer.dataFilename
        }

        EAInfoPage {
           //id: eventInfoPage
           property alias eventContainer: eaContainer
           property alias eventInfo: eaContainer.eaInfo
           property alias dataFilename: eaContainer.dataFilename
        }
        Rectangle {
            color: 'plum'
            implicitWidth: 300
            implicitHeight: 200
        }
        Rectangle {
            color: 'yellow'
            implicitWidth: 200
            implicitHeight: 200
        }
        Rectangle {
            color: 'brown'
            implicitWidth: 200
            implicitHeight: 200
        }
    }

    Settings {
        //category: geometry
        property alias x: appwin.x
        property alias y: appwin.y
        property alias width: appwin.width
        property alias height: appwin.height
    //}

    //Settings {
        //category: data
        property alias dataFilename: eaContainer.dataFilename
    }
}
