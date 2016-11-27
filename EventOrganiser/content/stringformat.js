

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

function headerText() {
    addStringFormat();
    var text = "";
    var titleFields = JSON.parse(eventSpeakers.titleFields);
    for ( var i=0 ; i < titleFields["headerFields"].length ; i++ ) {
        if (titleFields["headerFields"][i].inListView)
        {
            var formatStr = titleFields["headerFields"][i].format;
            var title = titleFields["headerFields"][i].field;
            var model = titleFields["headerFields"][i].modelName;
            var myData = dataModel.get(index);
            var reqField = myData[model];
            var item = formatStr.format([title, reqField]);
            //item = StrFormat.format(formatStr, [title, reqField]);
            text += item;
        }
    }
}

function popUpText() {
    addStringFormat();
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
            //item = StrFormat.format(formatStr, [title, reqField]);
            text += item;
        }
    }
}


























