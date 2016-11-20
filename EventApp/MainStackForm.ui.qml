import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qml"

Item {
    property alias listView1: listView1

    StackLayout {
        id: mainStack
        anchors.fill: parent


        ListView {
            id: listView1
            width: 110
            height: 160
            delegate: Item {
                x: 5
                width: 80
                height: 40
                Row {
                    id: row1
                    Rectangle {
                        width: 40
                        height: 40
                        color: colorCode
                    }

                    Text {
                        text: name
                        font.bold: true
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    spacing: 10
                }
            }
            model: DrawerModel {
            }
        }
        DownloadEvent {
            id: downloadEvent1
        }
    }


}
