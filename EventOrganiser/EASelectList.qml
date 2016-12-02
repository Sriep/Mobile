import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import "content"
import "qrc:/shared"
import EventAppData 1.0

EASelectListForm {
    function refreshLists (stack, model) {
        var countItemLists = eaContainer.eaItemLists.length;
        for (var i = 0; i < countItemLists; i++) {
            var newList = Qt.createComponent("qrc:/shared/DataList.qml", stack);
            newList.createObject(stack
                , {"eaItemList": eaContainer.eaItemLists[i]});
            console.log("name: ", eaContainer.eaItemLists[i].listName);
            console.log("drawmodel.count",model.count);
            model.append({
                "title" : eaContainer.eaItemLists[i].listName
            });
        } //for
    }
    addListBut.onClicked: {
        eaContainer.insertEmptyItemList(0, newListName.text);
        refreshLists(stackCtl, drawerModel);
    }

    //function newList

/*
    GroupBox {
        width: 300
        height: 500
        title: qsTr("Mobile view")
        StackLayout {
            id: stackCtl
            anchors.fill: parent
            property int topDrawerId: 0
            property int loadEventId: 1
            property alias drawerModel: drawerModel
            ListView {
                id: drawerView
                width: 110
                height: 160
                delegate: ListDelegate {
                    id: drawerDelegate
                    text: title
                }
                model: ListModel {
                    id: drawerModel
                    }
                }
                DownloadEvent {
                    id: downloadEvent
                }
            }
            Connections {
                target: eaContainer
                onLoadedEventApp: {
                    var countItemLists = eaContainer.eaItemLists.length;
                    for (var i = 0; i < countItemLists; i++) {
                        var newList = Qt.createComponent("qrc:/shared/DataList.qml", stackCtl);
                        newList.createObject(stackCtl
                            , {"eaItemList": eaContainer.eaItemLists[i]});
                        console.log("name: ", eaContainer.eaItemLists[i].listName);
                        drawerModel.append({
                            "title" : eaContainer.eaItemLists[i].listName
                        });
                    } //for
                } //onLoadedEventApp
            } //Connections
     } //GroupBox */
}


