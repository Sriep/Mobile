import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4

ListView {  
    id: dataList
    width: parent.width
    height: parent.height
    property  alias dataModel: dataModel
    model: ListModel {
        id: dataModel
    }
    delegate: DataListDelegate {
    }
}
