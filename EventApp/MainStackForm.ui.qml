import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qml"

Item {
    StackLayout {
        id: mainStack
        anchors.fill: parent

        DownloadEvent {
            id: downloadEvent1
        }
    }

}
