#include "eaitem.h"

EAItem::EAItem()
{

}

EAItem::EAItem(int itemType, const QString &title, const QString &displayText)
{
    setItemType(itemType);
    setTitle(title);
    setDisplayText(displayText);
}

EAItem::EAItem(const QString &title, const QUrl url)
{
    setItemType(ItemType::Url);
    setTitle(title);
    setUrl(url);
    setUrlString(url.toString());
}

void EAItem::read(const QJsonObject &json)
{
    setItemType(json["itemType"].toInt());
    setTitle(json["title"].toString());
    setDisplayText(json["displayText"].toString());
    setUrl(json["url"].toString());


    id = json["id"].toInt();
    version = json["version"].toInt();

}

void EAItem::write(QJsonObject &json)
{
    json["itemType"] = itemType();
    json["title"] = title();
    json["displayText"] = displayText();
    json["url"] = url().url();

    json["id"] = id;
    json["version"] = ++version;
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

QString EAItem::displayText() const
{
    return m_displayText;
}

QUrl EAItem::url() const
{
    return m_url;
}

QString EAItem::urlString() const
{
    return m_urlString;
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

void EAItem::setDisplayText(QString displayText)
{
    if (m_displayText == displayText)
        return;

    m_displayText = displayText;
    emit displayTextChanged(displayText);
}

void EAItem::setUrl(QUrl url)
{
    if (m_url == url)
        return;

    m_url = url;
    emit urlChanged(url);
}

void EAItem::setUrlString(QString urlString)
{
    if (m_urlString == urlString)
        return;

    m_urlString = urlString;
    emit urlStringChanged(urlString);
}
