import QtQuick 2.7

DownloadEventForm {
    property bool isExpanded: false
    downloadButton.onClicked: {
        console.log("Button Pressed. Entered text: ", urlText.text);
        progressBar.visible = true;
        httpDownload.downloadFile(urlText.text);
    }

    downloadKeyBut.onClicked: {
        console.log("Key Button Pressed. Entered text: ", downloadFromKey.text);
        progressKeyDL.visible = true;
        //httpDownload.downloadFile(keyText.text);
        eaContainer.downloadApp(downloadFromKey.text);
    }

    //void error(QString message);
    Connections {
        target: httpDownload
        onError: {
            console.log("download error", message);
            debugLog.text = message;
        }
    }


    quitButton.onClicked: {
        stackCtl.currentIndex = stackCtl.topDrawerId;
    }

    getDebugLog.onClicked: {
        debugLog.text = eaContainer.getDebugLog()
    }

}
