import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Extras 1.4

TextField {
  id: formatTextDelegate
  height: 30
  property int textIndex: -1
  text: {
      var data = titlesModel.get(index)
      formatTextDelegate.textIndex = index;
      text = data.format;
  }

  onEditingFinished: {
    var titleObj = titlesModel.get(textIndex);
    titleObj.format = text;
    titlesModel.set(textIndex, titleObj);
  }
}
