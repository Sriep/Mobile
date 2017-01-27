import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

UserLoginForm {
    property bool isExpanded: false

    registerBut.onPressed: {
        var userObj = eaContainer.user;
        //var result = userObj.registerUser(userIdTF.text, emailTB.text, passwordTB.text);
        userObj.registerUser(userIdTF.text, "", passwordTB.text);
    }

    logonBut.onPressed: {
        var result = eaContainer.user.login(userIdTF.text, passwordTB.text);
    }

    logoffBut.onPressed: {
        var result = eaContainer.user.logoff();
    }

    quitButton.onClicked: {
        stackCtl.currentIndex = stackCtl.topDrawerId;
    }

}
