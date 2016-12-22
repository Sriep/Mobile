import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "dataList.js" as DataListJS

DLImageDelegateForm {
//DataListDelegateForm {    
  id: imageDelegate

  topText.text: {
      return title;
  }

  bottomText.text: {
      return displayText;
  }
  property url showUrlUrl: "http://lllconf.co.uk/"
  transitions: Transition {
        // Make the state changes smooth
        ParallelAnimation {
            ColorAnimation { property: "color"; duration: 500 }
            NumberAnimation { duration: 300; properties: "detailsOpacity,x,contentY,height,width" }
        }
  }

  maDataDelegate.onClicked: {
      dataListImage.currentIndex = index;
      imageDelegate.state = imageDelegate.state == 'Details' ? "" : "Details";
      console.log("maDataDelegate index",index);
      console.log("maDataDelegate listView.currentIndex",dataList.currentIndex);
  }

  photoImage.width: eaLVItemList.showPhotos ? 50 : 0

}
