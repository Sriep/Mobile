import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "content"
//import EventAppData 1.0

Page {
    //id: eaInfoPage

    SwipeView {
        id: eaInfoView
        anchors.fill: parent
        currentIndex: eaInfoTabBar.currentIndex

        EAInfoName {
            //width: parent.width
        }
        EAInfoTheme {}
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

    footer: TabBar {
        id: eaInfoTabBar
        currentIndex: eaInfoView.currentIndex
        TabButton {
            text: qsTr("Name")
        }
        TabButton {
            text: qsTr("Theme")
        }
        TabButton {
           // text: eventInfoPage.eventInfo.organiserName
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
