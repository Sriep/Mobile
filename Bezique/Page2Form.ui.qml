import QtQuick 2.4

Item {
    width: 400
    height: 400

    Text {
        id: testLabel
        x: 15
        y: 141
        text: qsTr("This should be page 2. Score is " + player1.score)
        font.pixelSize: 12
    }

}
