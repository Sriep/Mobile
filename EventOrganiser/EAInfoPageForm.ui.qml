import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "content"

Item {
    property alias eaInfoSwipeView: eaInfoSwipeView
    property alias eaInfoPage: eaInfoPage
    Page {
        id: eaInfoPage
        SwipeView {
            id: eaInfoSwipeView
            anchors.fill: parent

            EAInfoNameForm {
            }
            EAInfoThemeForm {}
            Rectangle {
                color: 'brown'
                implicitWidth: 200
                implicitHeight: 200
            }

            Rectangle {
                color: 'yellow'
                implicitWidth: 200
                implicitHeight: 200
            }
        }
    }
}
