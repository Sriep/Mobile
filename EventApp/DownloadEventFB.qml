import QtQuick 2.0

DownloadEventFBForm {
    property bool isExpanded: false

    downloadKeyBut.onClicked: {
        console.log("Key Button Pressed. Entered text: ", downloadFromKey.text);
        progressKeyDL.visible = true;
        eaContainer.firbaseUrl = firebaseUrlTF.text;
        eaContainer.downloadAppEncoded(downloadFromKey.text);
    }

    quitButton.onClicked: {
        stackCtl.currentIndex = stackCtl.topDrawerId;
    }

    getDebugLog.onClicked: {
        debugLog.text = eaContainer.getDebugLog()
    }
}
