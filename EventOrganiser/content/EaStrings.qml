import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "qrc:///shared"

EaStringsForm {
    Connections {
        target: applyStringsBut
        onPressed: {
            eaContainer.eaConstruction.strings.tbLoggedOff = textLoggedOff.text;

            eaContainer.eaConstruction.strings.mLogin = textLogin.text
            eaContainer.eaConstruction.strings.mLoadFKey = textLoadfKey.text
            eaContainer.eaConstruction.strings.mLoadFFile = textLoadfFile.text
            eaContainer.eaConstruction.strings.mLoadFFirebase = textLaodfFirebase.text
            eaContainer.eaConstruction.strings.mAbout = textAbout.text
            eaContainer.eaConstruction.strings.mExit = textMenueExit.text

            eaContainer.eaConstruction.strings.lUserId = textUserId.text
            eaContainer.eaConstruction.strings.lPassword = textPasword.text

            eaContainer.eaConstruction.strings.bRegister = textRegister.text
            eaContainer.eaConstruction.strings.bLogin = textLogon.text
            eaContainer.eaConstruction.strings.bLogoff = textLogoff.text

            eaContainer.eaConstruction.strings.lkDownlaodFKey = textDownloadfKey.text
            eaContainer.eaConstruction.strings.lfDownloadUrl = textDownliadFIUrl.text
            eaContainer.eaConstruction.strings.lfFirebaseUrl = textFirebaseUrl.text
            eaContainer.eaConstruction.strings.bDownlaod = textDownload.text
            eaContainer.eaConstruction.strings.bExit = textExitBut.text

            eaContainer.eaConstruction.strings.aboutText = textAreaAbout.text
            eaContainer.eaConstruction.strings.emitStringChangedSignal()
        }
    }
}
