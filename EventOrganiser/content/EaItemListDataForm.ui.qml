import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0
import QtQuick.Controls.Styles 1.4

Item {
    property alias thisItemList: thisItemList
    property alias thisFormatedListPanel: thisFormatedListPanel
    property alias editItemEntryStack: editItemEntryStack

    StackLayout {
        id: editItemEntryStack
        x:10; y: 10
        width: parent.width; height: parent.height
        clip: true

        EaldFormatedList {
            width: parent.width; height: parent.height
            id: thisFormatedListPanel
        }
        EaldList {
            width: parent.width; height: parent.height
            id: thisItemList
        }

    } //StackLayout
}
