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
    title: qsTr("Hello World")

    EAContainer {
        id: eaContainer       
        eaConstruction: EAConstruction {}
        eaInfo: EAInfo {}

        Component.onCompleted: {
            console.log("Componet completed: ", eaContainer.dataFile);
            console.log("Data file: ", eaContainer.dataFile);
        }
    }

    HttpDownload {
        id: httpDownload
    }

    header: EaToolBar {}

    MainStack {}


    Settings {
        category: "geometry"
        property alias x: appwin.x
        property alias y: appwin.y
        property alias width: appwin.width
        property alias height: appwin.height
    }

    Settings {
        category: "data"
        property alias dataFilename: eaContainer.dataFilename
    }
}
