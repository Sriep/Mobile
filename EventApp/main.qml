import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Qt.labs.settings 1.0
import EventAppData 1.0

ApplicationWindow {
    id: appwin
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    EAContainer {
        id: eaContainer
        //dataFilname: ""
        eaConstruction: EAConstruction {}
        eaInfo: EAInfo {}
    }

    Settings {
        category: geometry
        property alias x: appwin.x
        property alias y: appwin.y
        property alias width: appwin.width
        property alias height: appwin.height
    }

    Settings {
        category: data
        property alias dataFilename: eaContainer.dataFilename
    }
}
