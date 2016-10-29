import QtQuick 2.7
import Bezique 1.0

Page1Form {

    button1.onClicked: {
        console.log("Button Pressed. Entered text: " + textField1.text);
    }
}
