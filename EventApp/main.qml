import QtQuick 2.7
import QtQuick.Controls 2.0
//import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import EventAppData 1.0
import "qrc:///shared"

ApplicationWindow {
    id: appwin
    visible: true
    width: 480; height: 640
    title: eaContainer.eaInfo.eventName

    property color backColour: EAConstruction.backColour
    property color foreColour: EAConstruction.foreColour
    property color textColour: EAConstruction.textColour

    Rectangle {
        color: appwin.backColour
        anchors.fill: parent
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

    EventAppPage {
        id: eventAppPage
        anchors.fill: parent
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
        property string dataFilename: "defaultData"
        property alias firebaseUrl: eaContainer.firbaseUrl
        property string style: "default"
        //property alias style: eaContainer.eaConstruction.style
        //property alias firebaseUrl: "https://eventapp-2d821.firebaseio.com/"
    }

    Settings {
        id: settingsUser
        category: "user"
        property string userName: ""
        property bool logedOn: false
    }
}
