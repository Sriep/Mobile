import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4


Item {
  //  Row {
       // id: row1
        height: 40
        Text {
            height: currentIndex
            text: field
            verticalAlignment: Text.AlignBottom
            font.bold: true
        }
        TextField {
            height: 20
            id: dispalyFormat
            placeholderText: delegate
        }
        CheckBox {
            id: checkListView
            text: qsTr("In list")
            checked: inListView
        }
   // }
}
