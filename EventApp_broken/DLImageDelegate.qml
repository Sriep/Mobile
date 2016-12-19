import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "dataList.js" as DataListJS

DLImageDelegateForm {
//DataListDelegateForm {
  topText.text: {
      return title;
  }

  bottomText.text: {
      return displayText;
  }

  transitions: Transition {
        // Make the state changes smooth
        ParallelAnimation {
            ColorAnimation { property: "color"; duration: 500 }
            NumberAnimation { duration: 300; properties: "detailsOpacity,x,contentY,height,width" }
        }
  }

  photoImage.width: eaLVItemList.showPhotos ? 50 : 0

}
