import QtQuick 2.7

DownloadEventForm {
    downloadButton.onClicked: {
        console.log("Button Pressed. Entered text: ", urlText.text);
        progressBar.visible = true;
        //httpDownload.url = ulrText.text;
        httpDownload.downloadFile(urlText.text);
        console.log("Exited download file");
    }
}
