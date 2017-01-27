import QtQuick 2.7

DownloadEventFileForm {
    property bool isExpanded: false
    downloadButton.onClicked: {
        console.log("Button Pressed. Entered text: ", urlText.text);
        progressBar.visible = true;
        eaContainer.downloadFromUrl(urlText.text);
        //httpDownload.downloadFile(urlText.text);
    }

/*
    //void error(QString message);
    Connections {
        target: httpDownload
        onError: {
            console.log("download error", message);
            debugLog.text = message;
        }
    }
*/

    quitButton.onClicked: {
        stackCtl.currentIndex = stackCtl.topDrawerId;
    }

    getDebugLog.onClicked: {
        debugLog.text = eaContainer.getDebugLog()
    }

}
