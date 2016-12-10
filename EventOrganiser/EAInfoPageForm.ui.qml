import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "content"

Item {
    property alias eaInfoSwipeView: eaInfoSwipeView
    property alias eaInfoPage: eaInfoPage
    Page {
        id: eaInfoPage
        RowLayout {
            id: eaInfoSwipeView
            anchors.fill: parent

            EAInfoName {
            }
           // EAInfoThemeForm {}
        }
    }
}
