import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.0
import Qt.labs.settings 1.0
import EventAppData 1.0
import "qml"

ApplicationWindow {
    id: appwin
    visible: true
    width: 480; height: 640
    //title: qsTr("Hi world")
    title: eaContainer.eaInfo.eventName

    property color backColour: EAConstruction.backColour
    property color foreColour: EAConstruction.foreColour
    property color textColour: EAConstruction.textColour

    Rectangle {
        color: appwin.backColour
        anchors.fill: parent
    }

    EaContainer {
        id: eaContainer
    }

    HttpDownload {
        id: httpDownload
        onFinishedDownload: {
            console.log("Download finished");
            eaContainer.loadNewEventApp();
        }
    }

    header: EaToolBar {
        id: toolBar
    }

    MainStack {
        id: mainStack
        property int topDrawerId: 0
        property int loadEventId: 1
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
    }
}
