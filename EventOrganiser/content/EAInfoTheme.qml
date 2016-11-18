import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import EventAppData 1.0

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
                //Layout.fillWidth: true
                ColumnLayout {
                    TextField {
                        placeholderText: qsTr("filename .json or .dat")
                        text: eventContainer.dataFilename
                    }
                    RowLayout {
                        height: implicitHeight
                        Button {
                            text: "Load"
                            onClicked: eventContainer.loadEventApp();
                        }
                        Button {
                            text: "Save"
                            onClicked: eventContainer.saveSaveEventApp();
                        }
                    } //RowLayout
                } //ColumnLayout
            } //GroupBox
        } // GridLayout
    } // Pane
} // Flickable
