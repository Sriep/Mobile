//import QtQuick 2.7
//import QtQuick.Controls 2.0
//import QtQuick.Layouts 1.1
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import Qt.labs.settings 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Event App designer")

    header: TabBar {
        id: headerTabBar
        anchors.fill: parent
        anchors.margins: 8
        //anchors.margins: UI.margin
        //tabPosition: UI.tabPosition
        Layout.minimumWidth: 360
        Layout.minimumHeight: 360
        Layout.preferredWidth: 480
        Layout.preferredHeight: 640

        TabButton {
            text: qsTr("The Event")
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

    //SwipeView {
    StackLayout {
        id: view
        currentIndex: headerTabBar.currentIndex
        anchors.fill: parent


        TheEvent {}
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

 /*
        Item {
            id: firstPage
        }
        Item {
            id: secondPage
        }
        Item {
            id: thirdPage
        }
    }
*/
}
