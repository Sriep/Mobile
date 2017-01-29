import QtQuick 2.7
import QtQuick.Layouts 1.3
//For 5.7 to 5.8 switch around QtQuickControls 2.1 and 2.0
//import QtQuick.Controls 2.1
import QtWebView 1.1
//import QtWebEngine 1.0
import QtQuick.Controls 2.0
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Extras 1.4
import "dataList.js" as DataListJS

Item {
    //Text{ text: "Whats up folks!"}

    // Create a property to contain the visibility of the details.
    // We can bind multiple element's opacity to this one property,
    // rather than having a "PropertyChanges" line for each element we
    // want to fade.
    property real detailsOpacity : 0
    width: dataListImage.width
    Layout.fillWidth: true
    height: eaContainer.eaConstruction.display.height
    property alias map: map
    property alias largePhotoImage: largePhotoImage
    property alias maDataDelegate: maDataDelegate
    property alias closeBut: closeBut
    property alias bottomText: bottomText
    property alias photoImage: photoImage
    property alias questionsModel: questionsModel
    property alias topText: topText    

    // A simple rounded rectangle for the background
    Rectangle {
        id: background
        x: eaContainer.eaConstruction.display.x
        y: eaContainer.eaConstruction.display.x
        width: parent.width - x*2;
        height: parent.height - y*2
        color: eaContainer.eaConstruction.display.colour
        border.color: eaContainer.eaConstruction.display.borderColour
        border.width: eaContainer.eaConstruction.display.borderWidth
        radius: eaContainer.eaConstruction.display.radius
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
        clip: true
        Image {
            id: photoImage
            width: 50;  height: 50
           // width: parent.width;  height: parent.height
            source: picture
            x:20; y:10
        }

        Text {
            id: topText
            font: eaContainer.eaConstruction.display.font
            color: eaContainer.eaConstruction.display.fontColour
            style: eaContainer.eaConstruction.display.textStyle
            styleColor: eaContainer.eaConstruction.display.styleColour
            x: eaContainer.eaConstruction.display.xText
            y: eaContainer.eaConstruction.display.yText
            verticalAlignment: eaContainer.eaConstruction.display.vAlignment
            horizontalAlignment: eaContainer.eaConstruction.display.hAlignment

            text:  eaLVItemList.items[itemIndex].title;
        }
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

        StackLayout {
            id: itemStackCtl
            currentIndex: itemType
            clip: true
            x: 20
            Item{
                //Text {
                //    text: picture
                //}

                Image {
                    id: largePhotoImage
                    width: parent.width//400//eventAppMainPage.width
                    height: parent.height
                    source: picture
                    x:20; y:10
                }
            }
            Item {
                Text {
                  id: bottomText;
                  wrapMode: Text.WordWrap;
                  width: details.width
                  text: eaLVItemList.items[itemIndex].displayText;
                }
            }

            Item {
                width: background.width-10; height: background.height-10
                opacity: imageDelegate.detailsOpacity
                visible: imageDelegate.detailsOpacity === 1 && itemType === 2
                clip: true
                WebView {
                    clip: true
                    opacity: imageDelegate.detailsOpacity
                    width: background.width-10; height: background.height-10
                    y: 5; x:5
                    url: eaLVItemList.items[itemIndex].url;
                }
            }

            ListView {
                width: eventAppMainPage.width
                height: eventAppMainPage.height //600
                model: ListModel {
                    id: questionsModel
                }
                delegate: Item {
                    x:10; y:50
                    //width: 250; height: 90
                    width: eventAppMainPage.width
                    height: 100

                    ColumnLayout {
                        //y:20
                        Text {
                            y: 10; x:15
                            height: 30 + 15*lineCount
                            width: eventAppMainPage.width - 2*y
                            text: question
                        }
                        Rectangle {
                            id: answerRec
                            y: 5; x:5
                            height: 60
                            width: eventAppMainPage.width - 60 //457
                            border.width : 0.5
                            border.color : "black"
                            anchors.rightMargin: 0
                            Flickable {
                                //id: answerFlick
                                width: eventAppMainPage.width - 80
                                y: 5; x:5
                                height: 60
                                TextArea.flickable: TextArea {
                                    id: answerTA
                                    width: eventAppMainPage.width -80//450
                                    height: 60 //+ 15*lineCount
                                    placeholderText: question
                                    text: answer
                                    wrapMode: TextArea.Wrap
                                    selectByMouse: true
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

            Item {
                Map {
                    x: 20
                    id: map
                    //width: 300; height: 499
                    anchors.fill: parent
                    center {
                        latitude: 52.665329
                        longitude: 1.346240
                    }
                    zoomLevel: 6
                }
            }

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











































