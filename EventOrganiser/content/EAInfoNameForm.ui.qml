import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    property alias textEventName: textEventName
    property alias saveInfo: saveInfo
    Flickable {
            id: eventNamePane
            width: parent.width
            RowLayout {
                width: parent.width;
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                GroupBox {
                    title: qsTr("Event")
                    ColumnLayout {
                        Label { text: qsTr("Event name"); wrapMode: Label.Wrap  }
                        TextField {
                            id: textEventName
                            placeholderText: qsTr("My event name")
                            cursorVisible: true
                            selectByMouse: true
                            focus: true
                            //text: eventInfo.eventName;
                        }

                        Button {
                            id: saveInfo
                            text: qsTr("Save")
                        } //GroupBox
                    } // ColumnLayout
                } //GroghdghupBox

              } // ColumnLayout

        ScrollBar.vertical: ScrollBar { }

    }


}
