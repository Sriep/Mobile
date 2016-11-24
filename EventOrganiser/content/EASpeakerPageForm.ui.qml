import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4

Item {
    property alias loadCsvBut: loadCsvBut
    Button {
        id: loadCsvBut
        x: 84
        y: 36
        text: qsTr("Load ")
    }

}
