#include <QJsonObject>
#include <QVariant>
#include <QDebug>

#include "eaconstruction.h"

EAConstruction::EAConstruction()
{
    m_display = new EAObjDisplay;
}

void EAConstruction::read(const QJsonObject &json)
{   
    setBackColour(QColor(json["backColour"].toString()));
    setForeColour(QColor(json["foreColour"].toString()));
    setFontColour(QColor(json["fontColour"].toString()));
    if (json.contains("display"))
    {
        m_display = new EAObjDisplay;
        m_display->read(json["display"].toObject());
    }
    setStyle(json["style"].toString());
}

void EAConstruction::write(QJsonObject &json) const
{   
    json["backColour"] = QVariant(m_backColour).toString();
    json["foreColour"] = QVariant(m_foreColour).toString();
    json["fontColour"] = QVariant(m_fontColour).toString();
    if (NULL != display())
    {
        QJsonObject displayObject;
        display()->write(displayObject);
        json["display"] = displayObject;
    }
    json["style"] = style();
    qDebug() << m_backColour.name() << m_foreColour.name()  << m_fontColour.name();
}

QColor EAConstruction::backColour() const
{
    return m_backColour;
}

QColor EAConstruction::foreColour() const
{
    return m_foreColour;
}

QFont EAConstruction::font() const
{
    return m_font;
}

QColor EAConstruction::fontColour() const
{
    return m_fontColour;
}

EAObjDisplay* EAConstruction::display() const
{
    return m_display;
}

QString EAConstruction::style() const
{
    return m_style;
}

void EAConstruction::setBackColour(QColor backColour)
{
    if (m_backColour == backColour)
        return;

    m_backColour = backColour;
    emit backColourChanged(backColour);
}

void EAConstruction::setForeColour(QColor foreColour)
{
    if (m_foreColour == foreColour)
        return;

    m_foreColour = foreColour;
    emit foreColourChanged(foreColour);
}

void EAConstruction::setFont(QFont font)
{
    if (m_font == font)
        return;

    m_font = font;
    emit mainChanged(font);
}

void EAConstruction::setFontColour(QColor fontColour)
{
    if (m_fontColour == fontColour)
        return;

    m_fontColour = fontColour;
    emit fontColourChanged(fontColour);
}

void EAConstruction::setDisplay(EAObjDisplay *display)
{
    if (m_display == display)
        return;

    m_display = display;
    emit displayChanged(display);
}

void EAConstruction::setStyle(QString style)
{
    if (m_style == style)
        return;

    m_style = style;
    emit styleChanged(style);
}
