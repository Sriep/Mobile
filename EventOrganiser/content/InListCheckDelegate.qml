import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4

CheckBox {
  id: inListCheckDelegate
  height: 30
  text: qsTr("In list")
  property int checkIndex: -1
  checked: {
     var data = titlesModel.get(index)
     inListCheckDelegate.checkIndex = index;
     checked = data.inListView;
 }
  
  onClicked: {      
      var titleObj = titlesModel.get(checkIndex);
      titleObj.inListView = checkState == Qt.Checked;
      titlesModel.set(checkIndex, titleObj);
  }
}
