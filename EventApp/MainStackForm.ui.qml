import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qml"

Item {
    property alias drawerView: drawerView
    property alias downloadEvent: downloadEvent
    property alias stackCtl: stackCtl

    StackLayout {
        id: stackCtl
        anchors.fill: parent
        ListView {
            id: drawerView
            width: 110
            height: 160
            delegate: ListDelegate {
                id: drawerDelegate
                text: title
            }
            model: ListModel {
                id: titlesModel
            }
            //model: DrawerModel {
            //    id: drawerModel
            //}
        }
        DownloadEvent {
            id: downloadEvent
        }
    }

}
