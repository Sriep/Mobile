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
        //color: "#212126"
        color: appwin.backColour
        anchors.fill: parent
    }

    EAContainer {
        id: eaContainer       
        eaConstruction: EAConstruction {}
        eaInfo: EAInfo {}

        Component.onCompleted: {
            console.log("Componet completed: ", eaContainer.dataFile);
            console.log("Settins filename: ", settingsData.dataFilename);
            dataFilename = settingsData.dataFilename;
            loadEventApp();
            console.log("Data file: ", eaContainer.dataFile);
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

    HttpDownload {
        id: httpDownload
        onFinishedDownload: {
            console.log("Download finished");
            eaContainer.loadEventApp();
            console.log("onFinishedDownload");
            console.log("Componet completed: ", eaContainer.dataFile);
            console.log("Data file: ", eaContainer.dataFile);
            console.log("back colour: ", eaContainer.backColour);
            console.log("fore colour: ", eaContainer.foreColour);
            console.log("font colour: ", eaContainer.textColour);
            console.log("event name: ", eaContainer.eaInfo.eventName);
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
