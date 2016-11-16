import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "content"
import EventAppData 1.0

Page {

    EventInfo {
        id: eventInfo
        eventName: qsTr("Landlord Law Conference 2017")
        eventDescription: qsTr("If you want solid legal training
for you and your staff - look no further.
We have 10 legal talks, all from specialist
 lawyers and trainers to make sure you are
bang up to date with the law.")
        organiserName: "Tessa Shepperson"
        organiserDescription: "Tessa Shepperson"
    }

    SwipeView {
        id: eventView
        anchors.fill: parent
        currentIndex: eventTabBar.currentIndex

        EventName {}
        EventTheme {}
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

        /*Repeater {
            model: 3

            Pane {
                width: swipeView.width
                height: swipeView.height

                Column {
                    spacing: 40
                    width: parent.width

                    Label {
                        width: parent.width
                        wrapMode: Label.Wrap
                        horizontalAlignment: Qt.AlignHCenter
                        text: "TabBar is a bar with icons or text which allows the user"
                              + "to switch between different subtasks, views, or modes."
                    }

                    Image {
                        source: "qrc:/images/arrows.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }*/
    }

    footer: TabBar {
        id: eventTabBar
        currentIndex: eventView.currentIndex
       // anchors.fill: parent
        //anchors.bottom: parent.bottom
       // anchors.margins: 8
        //anchors.margins: UI.margin
        //tabPosition: UI.tabPosition
        //Layout.minimumWidth: 360
        //Layout.minimumHeight: 360
        //Layout.preferredWidth: 480
        //Layout.preferredHeight: 640

        TabButton {
            text: qsTr("Name")
        }
        TabButton {
            text: qsTr("Theme")
        }
        TabButton {
            text: qsTr("Location")
        }
        TabButton {
            text: qsTr("Social Liinks")
        }
    }
}

//"id": 1,
//"name": "Open Tech Summit",
//"description": "The OpenTechSummit brings the exciting ideas and creators of the open-Technology community in Berlin.",
//"organizer_name": "FOSSASIA",
//"organizer_description": "Promoting open source ideas and technology throughout the world",

//"background_image": "http://2016.opentechsummit.net/img/15435769939_82ab5f1580_k.jpg",
//"logo": "/images/logo.png",

//"latitude": 52.52,
//"longitude": 13.405,
//"location_name": "Berlin",
//"start_time": "2016-05-05T09:00:00",
//"end_time": "2016-05-05T21:00:00",
//"timezone": "UTC",


//"social_links": [

//"ticket_url": "http://www.eventnook.com/event/ots16/register",
//"privacy": "public",
//"type": "Conference",
//"topic": "Science & Technology",
//"sub_topic": "Other",
//"code_of_conduct": "",
//"copyright": {
//    "holder": null,
//    "holder_url": null,
//    "licence": null,
//    "licence_url": null,
//   "logo": null,
//    "year": null
//},
//"call_for_papers": {
//    "announcement": "<p>Wanna speak at our prestigious event. Send us a proposal</p>",
//    "end_date": "2016-05-04T20:30:00",
//    "privacy": "public",
//    "start_date": "2016-05-01T19:30:00",
//    "timezone": "UTC"
//},
//"creator": {
//    "email": "s@g.com"
//},
//"email": "contact@opentechsummit.net",
//"has_session_speakers": true,
//"schedule_published_on": "2016-05-04T09:00:00",
//"searchable_location_name": null,
//"state": "Comp

