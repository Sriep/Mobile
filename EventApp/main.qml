import QtQuick 2.7
import QtQuick.Controls 2.0
//import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import Qt.labs.settings 1.0
import EventAppData 1.0
import "qrc:///shared"
import com.dreamdev.QtAdMobBanner 1.0
import com.dreamdev.QtAdMobInterstitial 1.0

ApplicationWindow {
    id: appwin
    visible: true
    //width: 480; height: 640 1280 x
    //width: 720; height: 1280
    width: settingsGeometry.width
    height: settingsGeometry.height
    property bool downloadFileOnly: true
    title: eaContainer.eaInfo.eventName

    EaContainerObj {
        id: eaContainer
    }

    Rectangle {
        color: appwin.backColour
        //width: appwin.width
        //height: appwin.height - 50
        anchors.fill: parent
    }

    EventAppPage {
        id: eventAppPage
        width: appwin.width
        //height: appwin.height - 50
        height: Qt.platform.os === "android" ? (appwin.height - 50) : appwin.height
    }
/*
    Component.onCompleted: {
        if (Qt.platform.os === "android" ) {
            var qmlString = "import QtQuick 2.7\n"
                    + "import QtQuick 2.7\n"
                    + "import com.dreamdev.QtAdMobBanner 1.0\n"
                    + "import com.dreamdev.QtAdMobInterstitial 1.0\n"
                    +"AdMobBanner {\n"
                        + "\tid: banner\n"
                        + "\ty:  Screen.devicePixelRatio * appwin.height -50\n"
                            + "\t\tComponent.onCompleted: {\n"
                            + "\t\tbanner.unitId = \"ca-app-pub-1142520693748162/7246793937\"\n"
                            + "\t\tappwin.height = eaContainer.screenHeight\n"
                            + "\t\tappwin.width = eaContainer.screenWidth\n"
                            + "\t}"
                            + "}\n";
             var newObject = Qt.createQmlObject(
                               qmlString
                              ,appwin
                              ,"dynamicSnippet1");
        }
    }
*/
/*
    AdMobBanner {
        id: banner
        y:  Screen.devicePixelRatio * appwin.height -50
        Component.onCompleted: {
            banner.unitId = "ca-app-pub-1142520693748162/7246793937"
            banner.size = AdMobBanner.Banner;
            banner.visible = true;
            console.log("banner onCompleted")
            //heightData();
        }
    }
*/
    Settings {
        id: settingsGeometry
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
        property string event: ""
    }

    Settings {
        id: settingsUser
        category: "user"
        property string userName: ""
        property bool logedOn: false
    }
}
