#include <QJsonObject>
#include <QVariant>
#include <QDebug>

#include "eaconstruction.h"

EAConstruction::EAConstruction()
{

}

void EAConstruction::read(const QJsonObject &json)
{   
    setBackColour(QColor(json["backColour"].toString()));
    setForeColour(QColor(json["foreColour"].toString()));
    setFontColour(QColor(json["fontColour"].toString()));
}

void EAConstruction::write(QJsonObject &json) const
{   
    json["backColour"] = QVariant(m_backColour).toString();
    json["foreColour"] = QVariant(m_foreColour).toString();
    json["fontColour"] = QVariant(m_fontColour).toString();

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
