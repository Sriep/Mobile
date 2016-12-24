import QtQuick 2.0
import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import QtWebEngine 1.0
import QtWebView 1.1
import "dataList.js" as DataListJS

Item {

    // Create a property to contain the visibility of the details.
    // We can bind multiple element's opacity to this one property,
    // rather than having a "PropertyChanges" line for each element we
    // want to fade.
    property real detailsOpacity : 0

    width: dataListImage.width
    height: 70
    property alias mouseAreaQLV: mouseAreaQLV
    property alias questionsList: questionsList
    property alias maDataDelegate: maDataDelegate
    property alias largePhotoImage: largePhotoImage
    property alias bottomText: bottomText
    property alias photoImage: photoImage
    property alias questionsModel: questionsModel

    //property alias bottomText: bottomText
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
        id: maDataDelegate
        anchors.fill: parent
        //onClicked: imageDelegate.state = imageDelegate.state == 'Details' ? "" : "Details";
    }

    // Lay out the page: picture, title and ingredients at the top, and method at the
    // bottom.  Note that elements that should not be visible in the list
    // mode have their opacity set to recipe.detailsOpacity.
    Row {
        id: topLayout
        x: 10; y: 10; height: photoImage.height; width: parent.width
        spacing: 10
        opacity: !imageDelegate.detailsOpacity
        Image {
            id: photoImage
            width: 50;  height: 50
            source: picture
        }

       // Column {
        //    width: background.width - photoImage.width - 20; height: photoImage.height
       //     spacing: 5
            Text { id: topText }
       // }
    }

    Item {
      id: details
      width: parent.width - 20
      anchors { top: topLayout.bottom; topMargin: 10; bottom: parent.bottom; bottomMargin: 10 }
      opacity: imageDelegate.detailsOpacity

      Flickable {
        id: flick
        width: parent.width
        //anchors { top: parent.top; bottom: parent.bottom }
        anchors.fill: parent

        contentHeight: bottomText.height
        clip: true
        x:5
        StackLayout {
            id: itemStackCtl
            currentIndex: itemType
            Image {
                id: largePhotoImage
                source: picture
            }
            Text {
              id: bottomText;
              wrapMode: Text.WordWrap;
              width: details.width
            }

            WebView {
                id: webView
                width: background.width-10; height: background.height-10
                y: 5; x:5
                url: showUrlUrl
            }

            ListView {
                id: questionsList
                model: ListModel {
                    id: questionsModel
                }
                delegate: Item {
                    // A simple rounded rectangle for the background
                    Rectangle {
                        //id: background
                        id: itemBackground
                        x: 2; y: 2; width: parent.width - x*2; height: parent.height - y*2
                        color: "ivory"
                        border.color: "orange"
                        radius: 5
                    }
                    ColumnLayout {
                        Text {
                            height: 30
                            text: question
                        }
                        TextField {
                            id: answer
                        }
                    }
                }
                MouseArea {
                    id: mouseAreaQLV
                    anchors.fill: parent
                }
            }
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

    states: State {
        id: dldStates
        name: "Details"

        PropertyChanges { target: background; color: "white" }
 /*       PropertyChanges {
            id: picSicePropCh;
            target: photoImage;
            width:  parent.width // eaLVItemList.showPhotos ? 130 : 0;
            height: parent.height //eaLVItemList.showPhotos ? 130 : 50;
        } */// Make picture bigger
        PropertyChanges { target: imageDelegate; detailsOpacity: 1; x: 0 } // Make details visible
        PropertyChanges { target: imageDelegate; height: dataListImage.height } // Fill the entire list area with the detailed view

        // Move the list so that this item is at the top.
        PropertyChanges { target: imageDelegate.ListView.view; explicit: true; contentY: imageDelegate.y }
        //PropertyChanges { target: imageDelegate.dataListImage.view; explicit: true; contentY: imageDelegate.y }
        // Disallow flicking while we're in detailed view
        PropertyChanges { target: imageDelegate.ListView.view; interactive: false }
        //PropertyChanges { target: imageDelegate.dataListImage.view; interactive: false }
    }

}











































