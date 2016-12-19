import QtQuick 2.7

DownloadEventForm {
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


    quitButton.onClicked: {
        stackCtl.currentIndex = stackCtl.topDrawerId;
    }
}
