import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick 2.7
import QtQuick.Controls 2.1



Dialog {
    id: fullFontDlg
    title: qsTr("Configure font")
    focus: true
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel

    function populateForm(font, colour) {
         fontForm.tempColour = colour;
         //fontForm.fontColour.colorDialog.currentColor = colour;
         fontForm.fontFamilyDlg.font = font;
         fontForm.boldBox.checked =  font.bold;
         fontForm.italicBox.checked = font.italic;
         fontForm.underlineBox.checked = font.underline;
         fontForm.overlineBox.checked= font.overline;
         fontForm.strikoutBox.checked = font.strikeout;
         fontForm.pointSizeSpin.value= font.pointSize;
         fontForm.pixelSizeSpin.value= font.pixelSize;
         fontForm.letterSpacingSpin.value= font.letterSpacing;
         fontForm.wordSpacingSpin.value= font.wordSpacing;
         fontForm.weightCombo.currentIndex = font.weight;
         fontForm.capitalizationCombo.currentIndex= font.capitalization;
    }

    function getFontColour() {
        return fontForm.tempColour ;
    }

    function updateFont(font) {
        font.family = fontForm.fontFamilyDlg.font.family
        font.bold = fontForm.boldBox.checked
        font.italic = fontForm.italicBox.checked
        font.underline = fontForm.underlineBox.checked
        font.overline = fontForm.overlineBox.checked
        font.strikeout = fontForm.strikoutBox.checked
        font.pointSize = fontForm.pointSizeSpin.value
        font.pixelSize = fontForm.pixelSizeSpin.value
        font.letterSpacing = fontForm.letterSpacingSpin.value
        font.wordSpacing = fontForm.wordSpacingSpin.value
        font.weight = fontForm.weightCombo.currentIndex
        font.capitalization = fontForm.capitalizationCombo.currentIndex
    }

    function cancelled() {
        console.log("cancelled fullFontDlg");
        fullFontDlg.reject();
    }
   // signal finished
    function oked () {
        console.log("oked fullFontDlg");
        fullFontDlg.accept();
    }

    contentItem: FontDlgForm {
        id: fontForm
        property color tempColour: "black"
    }
}




























