import QtQuick 2.0

EaldItemForm {
    //property alias featuredList: eaListDisplayPage.featuredList
    property var featuredItem: eaListDisplayPage.featuredList.items[eaListDisplayPage.featuredItemIndex];
    property int listIndex: eaListDisplayPage.featuredItemIndex


}
