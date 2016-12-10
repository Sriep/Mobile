#include "eaitem.h"

EAItem::EAItem()
{

}

EAItem::EAItem(int itemType, const QString &title, const QString &data)
{
    setItemType(itemType);
    setTitle(title);
    setData(data);
}

void EAItem::read(const QJsonObject &json)
{
    setItemType(json["itemType"].toInt());
    setTitle(json["title"].toString());
    setData(json["data"].toString());
}

void EAItem::write(QJsonObject &json) const
{
    json["itemType"] = itemType();
    json["title"] = title();
    json["data"] = data();
}

int EAItem::itemType() const
{
    return m_itemType;
}

QString EAItem::title() const
{
    return m_title;
}

QString EAItem::data() const
{
    return m_data;
}

void EAItem::setItemType(int itemType)
{
    if (m_itemType == itemType)
        return;

    m_itemType = itemType;
    emit itemTypeChanged(itemType);
}

void EAItem::setTitle(QString title)
{
    if (m_title == title)
        return;

    m_title = title;
    emit titleChanged(title);
}

void EAItem::setData(QString data)
{
    if (m_data == data)
        return;

    m_data = data;
    emit DataChanged(data);
}
