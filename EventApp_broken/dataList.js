// https://www.codeproject.com/tips/201899/string-format-in-javascript
// Sample usage.
// var str = "She {1} {0}{2} by the {0}{3}. {-1}^_^{-2}";
// str = str.format(["sea", "sells", "shells", "shore"]);
// alert(str);
function addStringFormat() {
    String.prototype.format = function (args) {
            var str = this;
            return str.replace(String.prototype.format.regex, function(item) {
                var intVal = parseInt(item.substring(1, item.length - 1));
                var replace;
                if (intVal >= 0) {
                    replace = args[intVal];
                } else if (intVal === -1) {
                    replace = "{";
                } else if (intVal === -2) {
                    replace = "}";
                } else {
                    replace = "";
                }
                return replace;
            });
    };
    String.prototype.format.regex = new RegExp("{-?[0-9]+}", "g");
}
/*
function displayText(titleFields, dataModel, header, eaItemList) {
    addStringFormat();
    var text = "";
    for ( var i=0 ; i < titleFields["headerFields"].length ; i++ ) {
        if (titleFields["headerFields"][i].inListView === header)
        {
            var formatStr = titleFields["headerFields"][i].format;
            var title = titleFields["headerFields"][i].field;
            var model = titleFields["headerFields"][i].modelName;
            var myData = dataModel.get(index);
            var reqField = myData[model];
            var formatArr = [];//[title, reqField];
            formatArr.push(title);
            formatArr.push(reqField);
            var item = formatStr.format(formatArr);
            text += item;
        }
    }
    var myArr = fieldsObjToArr(titleFields["headerFields"], dataModel.get(index));
    var topFormat = eaItemList.shortFormat;
    var t1 = topFormat.format(myArr);
    var bottomFormat = eaItemList.longFormat;
    var t2 = bottomFormat.format(myArr);
    text = header ? t1 : t2;
    return text;
}
*/
function fieldsObjToArr(titles, dataObj) {
    var formatArr = [];
    for ( var i=0 ; i < titles.length ; i++ )
    {
        var model = titles[i].modelName;
        var reqField = dataObj[model];
        formatArr.push(reqField);
    }
    return formatArr;
}

/*
function resetDataListModel(dataModel, name, dataList)
{
    dataModel.clear();
    for ( var j=0 ; j < dataList["dataItems"].length ; j++ ) {
        var whatis = dataList["dataItems"][j];
        dataModel.append(dataList["dataItems"][j]);
        var picturePath =  "image://" + name + "/" +j.toString();
        dataModel.setProperty(j, "picture", picturePath);
        var newData = dataModel.get(j);
    }
}*/


























