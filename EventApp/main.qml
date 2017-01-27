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

    title: eaContainer.eaInfo.eventName

    EaContainerObj {
        id: eaContainer
       // Component.onCompleted: {
            //appwin.height = eaContainer.screenHeight
            //appwin.width = eaContainer.screenWidth
            //heightData();
        //}
    }

    Rectangle {
        color: appwin.backColour
        //width: appwin.width
        //height: appwin.height - 50
        anchors.fill: parent
    }

   // onHeightChanged: {
        //heightData();
        //banner.y = eaContainer.screenHeight - banner.height;
        //eventAppPage.width = appwin.height;
        //banner.y = eventAppPage.height;
   // }

    EventAppPage {
        id: eventAppPage
        width: appwin.width
        height: appwin.height - 50
        //height: parent.height - 60
        //anchors.fill: parent
    }

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

    function heightData() {
        var b = banner;
        var eap = eventAppPage;
        var aw = appwin;
        var ec = eaContainer;
        console.log("Screen.devicePixelRatio ", Screen.devicePixelRatio);
        console.log("banner.y",banner.y);
        console.log("eventAppPage.height", eventAppPage.height);
        console.log("appwin.height",appwin.height);
        console.log("eaContainer.screenHeight", eaContainer.screenHeight);
        console.log("");
        //hightText.text = " banner.y " + banner.y + " appwin.height " + appwin.height
        //        + "\neaC " + eaContainer.screenHeight
        //         + " pt2PxlH " + eaContainer.point2PixelH + " this y " + y;
    }

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
