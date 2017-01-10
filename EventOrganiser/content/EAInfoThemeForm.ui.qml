import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    property alias button1: button1
    property alias button2: button2
    property alias textField1: textField1
    property alias eventNamePane: eventNamePane
    Flickable {
        Pane {
            id: eventNamePane
            width: parent.width
            GridLayout {
                width: parent.width;
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                GroupBox {
                    width: parent.width
                    title: qsTr("Data file")
                    ColumnLayout {
                        TextField {
                            id: textField1
                            placeholderText: qsTr("filename .json or .dat")
                            cursorVisible: true
                            selectByMouse: true
                        }
                        RowLayout {
                            height: implicitHeight
                            Button {
                                id: button2
                                text: "Load"
                            }
                            Button {
                                id: button1
                                text: "Save"
                            }
                        } //RowLayout
                    } //ColumnLayout
                } //GroupBox
            } // GridLayout
        } // Pane
    } // Flickable
}
