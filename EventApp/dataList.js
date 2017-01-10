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

function setDisplayParameters(displayData, rectangle, textBox) {
    rectangle.x = displayData.x
    rectangle.y = displayData.x
    rectangle.color = displayData.colour
    rectangle.border.color = displayData.borderColour
    rectangle.border.width = displayData.borderWidth
    rectangle.radius = displayData.radius

    textBox.font = displayData.font
    textBox.color = displayData.fontColour
    textBox.style = displayData.textStyle
    textBox.styleColor = displayData.styleColour
}




























