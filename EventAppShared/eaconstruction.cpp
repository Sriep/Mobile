#include <QJsonObject>
#include <QVariant>
#include <QDebug>

#include "eaconstruction.h"

EAConstruction::EAConstruction()
    : m_backColour (QColor("white"))
{
    m_display = new EAObjDisplay;
    m_toolBarDisplay = new EAObjDisplay;
    m_menuDisplay = new EAObjDisplay;

}

void EAConstruction::read(const QJsonObject &json)
{   
    setBackColour(QColor(json["backColour"].toString()));
    setForeColour(QColor(json["foreColour"].toString()));
    setFontColour(QColor(json["fontColour"].toString()));
    setStyle(json["style"].toString());
    if (json.contains("display"))
    {
        m_display = new EAObjDisplay;
        m_display->read(json["display"].toObject());
        m_display->setDisplayType(EAObjDisplay::DisplayType::Drawer);
    }
    if (json.contains("toolBarDisplay"))
    {
        m_toolBarDisplay = new EAObjDisplay;
        m_toolBarDisplay->read(json["toolBarDisplay"].toObject());
        m_display->setDisplayType(EAObjDisplay::DisplayType::Toolbar);
    }
    if (json.contains("menuDisplay"))
    {
        m_menuDisplay = new EAObjDisplay;
        m_menuDisplay->read(json["menuDisplay"].toObject());
        m_display->setDisplayType(EAObjDisplay::DisplayType::Menu);
    }
}

void EAConstruction::write(QJsonObject &json) const
{   
    json["backColour"] = QVariant(m_backColour).toString();
    json["foreColour"] = QVariant(m_foreColour).toString();
    json["fontColour"] = QVariant(m_fontColour).toString();
    json["style"] = style();

    QJsonObject displayObject;
    display()->write(displayObject);
    json["display"] = displayObject;

    QJsonObject toolBarDispalyObject;
    toolBarDisplay()->write(toolBarDispalyObject);
    json["toolBarDisplay"] = toolBarDispalyObject;

    QJsonObject menuDisplayObject;
    menuDisplay()->write(menuDisplayObject);
    json["menuDisplay"] = menuDisplayObject;
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

QString EAConstruction::style() const
{
    return m_style;
}

EAObjDisplay* EAConstruction::display() const
{
    return m_display;
}

EAObjDisplay *EAConstruction::toolBarDisplay() const
{
    return m_toolBarDisplay;
}

EAObjDisplay* EAConstruction::menuDisplay() const
{
    return m_menuDisplay;
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

void EAConstruction::setToolBarDisplay(EAObjDisplay* toolBarDisplay)
{
    if (m_toolBarDisplay == toolBarDisplay)
        return;

    m_toolBarDisplay = toolBarDisplay;
    emit toolBarDisplayChanged(toolBarDisplay);
}

void EAConstruction::setMenuDisplay(EAObjDisplay *menuDisplay)
{
    if (m_menuDisplay == menuDisplay)
        return;

    m_menuDisplay = menuDisplay;
    emit menuDisplayChanged(menuDisplay);
}
