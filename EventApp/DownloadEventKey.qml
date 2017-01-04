import QtQuick 2.0

DownloadEventKeyForm {
    property bool isExpanded: false
    downloadKeyBut.onClicked: {
        console.log("Key Button Pressed. Entered text: ", downloadFromKey.text);
        progressKeyDL.visible = true;
        //httpDownload.downloadFile(keyText.text);
        eaContainer.downloadAppEncoded(downloadFromKey.text);
    }

    quitButton.onClicked: {
        var ss = stackCtl;
        stackCtl.currentIndex = stackCtl.topDrawerId;
    }

    getDebugLog.onClicked: {
        debugLog.text = eaContainer.getDebugLog()
    }

}
