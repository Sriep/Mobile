import QtQuick 2.7

DownloadEventFileForm {
    id: downloadEventFileForm
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

    Connections {
        target: downloadEventFileForm
        Component.onCompleted: {
            console.log("DownloadEventFileForm oncompleted");
            toolBar.titleLabel.text = eaContainer.eaConstruction.strings.lfDownloadUrl
            //eaContainer.eaConstruction.strings.lfDownloadUrl
        }
   }
*/
    quitButton.onClicked: {
        stackCtl.currentIndex = stackCtl.topDrawerId;
    }

    getDebugLog.onClicked: {
        debugLog.text = eaContainer.getDebugLog()
    }

    Connections {
        target: copyClipBut;
        onPressed: {
            urlText.text = eaContainer.copyFromClipboard();
        }
    }

}
