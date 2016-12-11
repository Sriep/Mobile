import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import "qrc:///shared"
import "content"

Item {
    //property alias addListBut: addListBut
    //property alias newListName: newListName
    property alias eventAppPage: eventAppPage
    RowLayout {
        id: rowLayout1
        anchors.fill: parent
        AddNewList {
            id: groupBox1
            width: 200; height: 200
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        }

        EventAppPage {
            id: eventAppPage
        }
    }
}
