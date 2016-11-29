import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import "common.js" as CommonJS

Item {
  /*width: 80
  height: 40
  Text {
     text: Name
     font.bold: true
     anchors.verticalCenter: parent.verticalCenter
  }*/

//Rectangle {
//        id: page
// //       width: 400; height: 240
 //       color: "black"
    //}
    //Component{
    id: dataDelegate

    // Create a property to contain the visibility of the details.
    // We can bind multiple element's opacity to this one property,
    // rather than having a "PropertyChanges" line for each element we
    // want to fade.
    property real detailsOpacity : 0

    width: dataList.width
    height: 70

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
        x: 10; y: 10; height: recipeImage.height; width: parent.width
        spacing: 10

        Image {
            id: recipeImage
            width: 50; height: 50
            //source: picture
        }

        Column {
            width: background.width - recipeImage.width - 20; height: recipeImage.height
            spacing: 5
            // var str = "She {1} {0}{2} by the {0}{3}. {-1}^_^{-2}";
            // str = str.format(["sea", "sells", "shells", "shore"]);
            Text {
                text: {
                    CommonJS.displayText(JSON.parse(eventSpeakers.titleFields)
                                         , dataModel
                                         , true);
                    /*CommonJS.addStringFormat();
                    var text = "";
                    var titleFields = JSON.parse(eventSpeakers.titleFields);
                    for ( var i=0 ; i < titleFields["headerFields"].length ; i++ ) {
                        if (titleFields["headerFields"][i].inListView)
                        {
                            var formatStr = titleFields["headerFields"][i].format;
                            var title = titleFields["headerFields"][i].field;
                            var model = titleFields["headerFields"][i].modelName;
                            var whatIndex = index;
                            var myData = dataModel.get(index);
                            var reqField = myData[model];
                            var item = formatStr.format([title, reqField]);
                            text += item;
                        }
                    }
                    return text;*/
                }
            }
        }
    }

    Item {
        id: details
        x: 10; width: parent.width - 20

        anchors { top: topLayout.bottom; topMargin: 10; bottom: parent.bottom; bottomMargin: 10 }
        opacity: dataDelegate.detailsOpacity
        /*
        Text {
            font.pixelSize: 12
            id: methodTitle
            anchors.top: parent.top
            text: "Method"
            font.pointSize: 12; font.bold: true
        }

        Flickable {
            id: flick
            width: parent.width
            anchors { top: methodTitle.bottom; bottom: parent.bottom }
            contentHeight: methodText.height
            clip: true

            Text { id: methodText; text: method; wrapMode: Text.WordWrap; width: details.width }
        }*/

        Flickable {
            id: flick
            width: parent.width
            anchors { top: parent.bottom; bottom: parent.bottom }
            contentHeight: methodText.height
            clip: true

            Text {
                id: methodText;
                text: {
                    CommonJS.displayText(JSON.parse(eventSpeakers.titleFields)
                                         , dataModel
                                         , false);
                    /*CommonJS.addStringFormat();
                    var text = "";
                    var titleFields = JSON.parse(eventSpeakers.titleFields);
                    for ( var i=0 ; i < titleFields["headerFields"].length ; i++ ) {
                        if (!titleFields["headerFields"][i].inListView)
                        {
                            var formatStr = titleFields["headerFields"][i].format;
                            var title = titleFields["headerFields"][i].field;
                            var model = titleFields["headerFields"][i].modelName;
                            var myData = dataModel.get(index);
                            var reqField = myData[model];
                            var item = formatStr.format([title, reqField]);
                            text += item;
                        }
                    }*/
                }
                wrapMode: Text.WordWrap;
                width: details.width }

        }

        Image {
            anchors { right: flick.right; top: flick.top }
            source: "qrc:/images/moreUp.png"
            opacity: flick.atYBeginning ? 0 : 1
        }

        Image {
            anchors { right: flick.right; bottom: flick.bottom }
            source: "qrc:/images/moreDown.png"
            opacity: flick.atYEnd ? 0 : 1
        }
    }

    // A button to close the detailed view, i.e. set the state back to default ('').
    //TextButton {
    //    y: 10
    //    anchors { right: background.right; rightMargin: 10 }
    //    opacity: recipe.detailsOpacity
    //    text: "Close"

    //    onClicked: recipe.state = '';
    //}

    states: State {
        name: "Details"

        PropertyChanges { target: background; color: "white" }
        PropertyChanges { target: recipeImage; width: 130; height: 130 } // Make picture bigger
        PropertyChanges { target: dataDelegate; detailsOpacity: 1; x: 0 } // Make details visible
        PropertyChanges { target: dataDelegate; height: dataList.height } // Fill the entire list area with the detailed view

        // Move the list so that this item is at the top.
        //PropertyChanges { target: dataDelegate.ListView.view; explicit: true; contentY: dataDelegate.y }
        PropertyChanges { target: dataDelegate.dataList.view; explicit: true; contentY: dataDelegate.y }
        // Disallow flicking while we're in detailed view
        PropertyChanges { target: dataDelegate.dataList.view; interactive: false }
    }

    transitions: Transition {
        // Make the state changes smooth
        ParallelAnimation {
            ColorAnimation { property: "color"; duration: 500 }
            NumberAnimation { duration: 300; properties: "detailsOpacity,x,contentY,height,width" }
        }
    }

}
