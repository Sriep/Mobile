import QtQuick 2.0
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "dataList.js" as DataListJS

Item {
    id: dataDelegate

    // Create a property to contain the visibility of the details.
    // We can bind multiple element's opacity to this one property,
    // rather than having a "PropertyChanges" line for each element we
    // want to fade.
    property real detailsOpacity : 0

    width: dataList.width
    height: 70
    property alias photoImage: photoImage
    property alias bottomText: bottomText
    property alias topText: topText

    // A simple rounded rectangle for the background
    Rectangle {
        id: background
        x: 2; y: 2; width: parent.width - x*2; height: parent.height - y*2
        color: "ivory"
        border.color: "orange"
        radius: 5
    }

    // This mouse region covers the entire delegate.
    // When clicked it changes mode to 'Details'.  If we are already
    // in Details mode, then no change will happen.
    MouseArea {
        anchors.fill: parent
        onClicked: dataDelegate.state = dataDelegate.state == 'Details' ? "" : "Details";
    }

    // Lay out the page: picture, title and ingredients at the top, and method at the
    // bottom.  Note that elements that should not be visible in the list
    // mode have their opacity set to recipe.detailsOpacity.
    Row {
        id: topLayout
        x: 10; y: 10; height: photoImage.height; width: parent.width
        spacing: 10

        Image {
            id: photoImage
            width: 50;  height: 50
            source: picture
        }

        Column {
            width: background.width - photoImage.width - 20; height: photoImage.height
            spacing: 5
            Text { id: topText }
        }
    }
/*
    SlitItemView {
        id: topLayout
        height: photoImage.height; width: parent.width
        spacing: 10
        property alias photoImage: photoImage
        property alias topText: topText
    }
*/
    Item {
      id: details
      width: parent.width - 20
      anchors { top: topLayout.bottom; topMargin: 10; bottom: parent.bottom; bottomMargin: 10 }
      opacity: dataDelegate.detailsOpacity

      Flickable {
        id: flick
        width: parent.width
        anchors { top: parent.top; bottom: parent.bottom }
        contentHeight: bottomText.height
        clip: true
        x:5
        Text {
          id: bottomText;
          wrapMode: Text.WordWrap;
          width: details.width
        }
      }

      Image {
        anchors { right: flick.right; top: flick.top }
        source: "qrc:///shared/images/moreUp.png"
        opacity: flick.atYBeginning ? 0 : 1
      }

      Image {
        anchors { right: flick.right; bottom: flick.bottom }
        source: "qrc:///shared/images/moreDown.png"
        opacity: flick.atYEnd ? 0 : 1
      }
    }
/*
    ExpandedItemView {
        id: details
        x: 10
    }
*/
    states: State {
        id: dldStates
        name: "Details"

        PropertyChanges { target: background; color: "white" }
        PropertyChanges {
            id: picSicePropCh;
            target: photoImage;
            width: eaLVItemList.showPhotos ? 130 : 0;
            height: eaLVItemList.showPhotos ? 130 : 50;
        } // Make picture bigger
        PropertyChanges { target: dataDelegate; detailsOpacity: 1; x: 0 } // Make details visible
        PropertyChanges { target: dataDelegate; height: dataList.height } // Fill the entire list area with the detailed view

        // Move the list so that this item is at the top.
        PropertyChanges { target: dataDelegate.ListView.view; explicit: true; contentY: dataDelegate.y }
        //PropertyChanges { target: dataDelegate.dataList.view; explicit: true; contentY: dataDelegate.y }
        // Disallow flicking while we're in detailed view
        PropertyChanges { target: dataDelegate.ListView.view; interactive: false }
        //PropertyChanges { target: dataDelegate.dataList.view; interactive: false }
    }

}











































