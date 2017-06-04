import QtQuick 2.7
import QtQuick.Layouts 1.3
//For 5.7 to 5.8 switch around QtQuickControls 2.1 and 2.0
//import QtQuick.Controls 2.1
import QtWebView 1.1
import QtQuick.Controls 2.0
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Extras 1.4
import "dataList.js" as DataListJS

Item {
    id: pageDisplay
    //width: parent.width - 20
    anchors { top: topLayout.bottom; topMargin: 10; bottom: parent.bottom; bottomMargin: 10 }
    opacity: imageDelegate.detailsOpacity
    clip: true
    
    Flickable {
        //id: flick
        width: parent.width
        //anchors { top: parent.top; bottom: parent.bottom }
        anchors.fill: parent
        //contentHeight: bottomText.height
        clip: true
        
        StackLayout {
            //id: itemStackCtl
            currentIndex: itemType
            clip: true
            x: 10
            Item {
                Image {
                    //id: largePhotoImage
                    width: parent.width//400//eventAppMainPage.width
                    height: parent.height
                    source: picture
                    x:20; y:10
                }
            }
            
            Item {
                Flickable {
                    anchors.fill: parent
                    contentHeight: bottomText.height
                    Text {
                        id: bottomText;
                        wrapMode: Text.WordWrap;
                        width: pageDisplay.width
                        text: eaLVItemList.items[itemIndex].displayText;
                    }
                    ScrollBar.vertical: ScrollBar { }
                }
            }
            
            Item {
                opacity: imageDelegate.detailsOpacity
                visible: imageDelegate.detailsOpacity === 1 && itemType === 2
                clip: true
                
                WebViewPage {
                    id: webViewPage
                }
            }
            
            ListView {
                width: eventAppMainPage.width
                height: eventAppMainPage.height
                //width: eventAppPage.width
                //height: eventAppPage.height
                
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
                        latitude:  eaLVItemList.items[itemIndex].mapInfo.latitude;
                        longitude:  eaLVItemList.items[itemIndex].mapInfo.longitude;
                    }
                    zoomLevel: eaLVItemList.items[itemIndex].mapInfo.zoomLevel;
                    MapQuickItem {
                        id: marker
                        //anchorPoint.x: image.width/4
                        //anchorPoint.y: image.height/4
                        //sourceItem:
                        zoomLevel: eaLVItemList.items[itemIndex].mapInfo.zoomLevel;
                        coordinate {
                            latitude:  eaLVItemList.items[itemIndex].mapInfo.latitude;
                            longitude:  eaLVItemList.items[itemIndex].mapInfo.longitude;
                        }
                        sourceItem: Image {
                            id: image
                            source: "qrc:/shared/images/marker.png"
                        }
                    }
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
