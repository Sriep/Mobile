#include <QJsonArray>
#include "eaitemcollection.h"

EAItemCollection::EAItemCollection()
{

}

EAItemCollection::EAItemCollection(const QString name)
    : EAItemListBase(name)
{

}

void EAItemCollection::read(const QJsonObject &json, QQmlEngine *engine)
{
    QJsonArray itemsArray = json["itemsList"].toArray();
    for (int i = 0; i < itemsArray.size(); ++i) {
        QJsonObject readJsonObject = itemsArray[i].toObject();
        EAItem* newItem = new EAItem();
        newItem->read(readJsonObject);
        m_eaItems.append(newItem);
    }
}

void EAItemCollection::write(QJsonObject &json) const
{
    QJsonArray itemsArray;
    foreach (EAItem* item, m_eaItems)
    {
        {
            QJsonObject itemObject;
            item->write(itemObject);
            itemsArray.append(itemObject);
        }
    }
    json["itemsList"] = itemsArray;
}

QQmlListProperty<EAItem> EAItemCollection::itemList() const
{
    return m_items;
}

//typedef QQmlListProperty::AppendFunction
//Synonym for void (*)(QQmlListProperty<T> *property, T *value).
//Append the value to the list property.
void EAItemCollection::append_eaItems(QQmlListProperty<EAItem> *list
                                     , EAItem *itemList)
{
    EAItemCollection *eaItemColl = qobject_cast<EAItemCollection *>(list->object);
    if (itemList) {
        //itemList->setParentItem(eaContainer); //???
        eaItemColl->m_eaItems.append(itemList);
    }
}

//typedef QQmlListProperty::CountFunction
//Synonym for int (*)(QQmlListProperty<T> *property).
//Return the number of elements in the list property.
int EAItemCollection::count_eaItems(QQmlListProperty<EAItem> *list)
{
    EAItemCollection *eaItemColl = qobject_cast<EAItemCollection *>(list->object);
    return eaItemColl->m_eaItems.count();
}

//typedef QQmlListProperty::AtFunction
//Synonym for T *(*)(QQmlListProperty<T> *property, int index).
//Return the element at position index in the list property.
EAItem* EAItemCollection::at_eaItems(QQmlListProperty<EAItem> *list
                                        , int index)
{
    EAItemCollection *eaItemColl = qobject_cast<EAItemCollection *>(list->object);
    return eaItemColl->m_eaItems[index];
}

//typedef QQmlListProperty::ClearFunction
//Synonym for void (*)(QQmlListProperty<T> *property).
//Clear the list property.
void EAItemCollection::clear_eaItems(QQmlListProperty<EAItem> *list)
{
    EAItemCollection *eaItemColl = qobject_cast<EAItemCollection *>(list->object);
    eaItemColl->m_eaItems.clear();
}
