import QtQuick 2.7
import QtQuick.Layouts 1.3
//For 5.7 to 5.8 switch around QtQuickControls 2.1 and 2.0
//import QtQuick.Controls 2.1
import QtWebView 1.1
//import QtWebEngine 1.0
import QtQuick.Controls 2.0

import QtQuick.Extras 1.4


//import Qt.labs.platform 1.0
import "dataList.js" as DataListJS

Item {
    //Text{ text: "Whats up folks!"}

    // Create a property to contain the visibility of the details.
    // We can bind multiple element's opacity to this one property,
    // rather than having a "PropertyChanges" line for each element we
    // want to fade.
    property real detailsOpacity : 0

    width: dataListImage.width
    height: 70
    //property alias questionsList: questionsList
    property alias maDataDelegate: maDataDelegate
    property alias closeBut: closeBut
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
            clip: true

            Image {
                //id: largePhotoImage
                source: picture
            }

            Text {
              id: bottomText;
              wrapMode: Text.WordWrap;
              width: details.width
            }


            Item {
                width: background.width-10; height: background.height-10
                opacity: imageDelegate.detailsOpacity
                visible: imageDelegate.detailsOpacity === 1 && itemType === 2
                WebView {
                    //id: webView
                    width: background.width-10; height: background.height-10
                    //height: imageDelegate.detailsOpacity ? background.height-10 : 0
                    //width: 0; height: 0
                    //opacity: imageDelegate.detailsOpacity
                    //visible: false
                    y: 5; x:5
                    url: showUrlUrl
                }
            }

            ListView {
                //id: questionsList
                //width: background.width-10; height: background.height-10
                //width: flick.width-10; height: flick.height-10
                width: 250; height: 600
                //x:10; y:10
                model: ListModel {
                    id: questionsModel
                }
                delegate: Item {
                    x:10; y:10
                    width: 250; height: 90
                    ColumnLayout {
                        Text {
                            y: 15; x:15
                            height: 30
                            text: question
                        }
                        Rectangle {
                            y: 5; x:5
                            width: 250; height: 60
                            //x: 2; y: 2; width: parent.width - x*2; height: parent.height - y*2
                            border.width : 0.5
                            border.color : "black"
                            anchors.rightMargin: 0
                            Flickable {
                                anchors.fill: parent
                                y: 5; x:5
                                TextArea.flickable: TextArea {
                                    id: answerTA
                                    y: 5; x:5
                                    placeholderText: question
                                    text: answer
                                    wrapMode: TextArea.Wrap
                                }
                                ScrollBar.vertical: ScrollBar { }
                                Connections {
                                    target: answerTA
                                    onEditingFinished: saveAnswer(answerTA.text, index)
                                }
                            } // Flickable
                        } //Rectangle
                    } //ColumnLayout
                } //delegate: Item
            } //ListView

        } //StackLayout
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

    // A button to close the detailed view, i.e. set the state back to default ('').
    Button {
        id: closeBut
        y: 10
        anchors { right: background.right; rightMargin: 10 }
        opacity: imageDelegate.detailsOpacity
        text: "Close"
        //text: dataDelegate.state === 'Details' ? "Close" : "Open"
        checked: true
        //onClicked: dataDelegate.state === 'Details' ? "Details" : "";
        //onClicked: dataDelegate.state === 'Details' ? "" : "Details";
    }

    states: State {
        id: dldStates
        name: "Details"

        PropertyChanges { target: background; color: "white" }

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











































