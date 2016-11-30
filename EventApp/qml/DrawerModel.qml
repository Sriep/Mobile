import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4

ListModel {
    //////id: drawerModel
    ListElement {
        title: "Schedule"
        page: "Schedule.qml"
    }
    ListElement {
        title: "Speakers"
        page: "Speakers.qml"
    }
    ListElement {
        title: "Delegates"
        page: "Delegates.qml"
    }
    ListElement {
        title: "News"
        page: "News.qml"
    }
    ListElement {
        title: "Venue"
        page: "Venue.qml"
    }
    ListElement {
        title: "Forum"
        page: "content/Forum.qml"
    }
}
