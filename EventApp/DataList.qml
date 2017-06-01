import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4
import EventAppData 1.0
import "qrc:///shared/dataList.js" as DataListJS

ListView {
    id: dataList

    property EAItemList eaLVItemList: undefined
    property bool isExpanded: false
    property int temp: 54

    onEaLVItemListChanged: {
        resetDataListModel();
    }

    Connections {
        target: eaLVItemList
        onEaItemListChanged: {
            resetDataListModel()
            refreshLists(stackCtl, drawerModel)
        }
    }

    model: ListModel { id: dataModel }
    delegate: DataListDelegate { id: thisDataDelgate
        onStateChanged: {
            dataList.isEzxpanded = state === "Details";
        }
        Connections {
            target: eaContainer
            onEaConstructionChanged: {
                setDisplayParameters();
            }
        }
        Component.onCompleted: {
            setDisplayParameters();
        }
    }

    function resetDataListModel() {
        var tempt = dataList.temp;
        var itemlist = eaLVItemList;
        var name = eaLVItemList.listName;
        var eaDataList = JSON.parse(eaLVItemList.dataList);
        var mm = dataModel;
        var dall = eaDataList["dataItems"].length;
        dataModel.clear();
        for ( var j=0 ; j < eaDataList["dataItems"].length ; j++ ) {
            var whatis = eaDataList["dataItems"][j];
            dataModel.append(eaDataList["dataItems"][j]);
            var picturePath = "image://list_";
            picturePath += eaLVItemList.getIndex().toString();
            picturePath += "_" + eaContainer.imageVersion;
            picturePath += "/" +j.toString();
            dataModel.setProperty(j, "picture", picturePath);
            dataModel.setProperty(j,"showPhoto", eaLVItemList.showPhotos)
            console.log("resetDataListModel picturePath", picturePath);
            var newData = dataModel.get(j);
        }
    }

}

