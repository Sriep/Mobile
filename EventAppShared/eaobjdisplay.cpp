#include "eaobjdisplay.h"

EAObjDisplay::EAObjDisplay()
{

}

EAObjDisplay::EAObjDisplay(EAObjDisplay::DisplayType disType)
{
    setDisplayType(disType);
}

void EAObjDisplay::read(const QJsonObject &json)
{
    setX(json["x"].toInt());
    setY(json["y"].toInt());
    setWidth(json["width"].toInt());
    setHeight(json["height"].toInt());    
    setImageHeight(json["imageHeigth"].toInt());
    setImageWidth(json["imageWidth"].toInt());
    setXImage(json["xImage"].toInt());
    setYImage(json["yImage"].toInt());
    setColour(QColor(json["colour"].toString()));
    setBorderColour(QColor(json["borderColour"].toString()));
    setBorderWidth(json["borderWidth"].toInt());
    setRadius(json["radius"].toInt());
    setFont(json2Font(json["font"].toObject()));
    setFontColour(QColor(json["fontColour"].toString()));
    setTextStyle(json["textStyle"].toInt());
    setStyleColour(QColor(json["styleColour"].toString()));
    setXText(json["xText"].toInt());
    setYText(json["yText"].toInt());
    setVAlignment(json["vAlignmet"].toInt());
    setHAlignment(json["hAlignment"].toInt());
    setBackColour(QColor(json["backColour"].toString()));
    setHighlitedColour(QColor(json["highlitedColour"].toString()));
    setWhiteIcons(json["whiteIcons"].toBool());
    //setDisplayType(json["displayType"].toInt());
    emit displayParamtersChanged();
}

void EAObjDisplay::write(QJsonObject &json)
{
    json["x"] = x();
    json["y"] = y();
    json["width"] = width();
    json["height"] = height();    
    json["imageHeigth"] = imageHeight();
    json["imageWidth"] = imageWidth();
    json["xImage"] = xImage();
    json["yImage"] = yImage();
    json["colour"] = QVariant(colour()).toString();
    json["borderColour"] = QVariant(borderColour()).toString();
    json["borderWidth"] = borderWidth();
    json["radius"] = radius();
    json["font"] = font2Json(font());
    json["fontColour"] = QVariant(fontColour()).toString();
    json["textStyle"] = textStyle();
    json["styleColour"] = QVariant(styleColour()).toString();
    json["xText"] = xText();
    json["yText"] = yText();
    json["vAlignmet"] = vAlignment();
    json["hAlignment"] = hAlignment();
    json["backColour"] = QVariant(backColour()).toString();
    json["highlitedColour"] = QVariant(backColour()).toString();
    json["whiteIcons"] = whiteIcons();
    //json["displayType"] = displayType();
}

QFont EAObjDisplay::json2Font(const QJsonObject& json)
{
    QFont font;
    font.setFamily(json["family"].toString());
    font.setItalic(json["italic"].toBool());
    font.setUnderline(json["underline"].toBool());
    font.setPointSize(json["pointSize"].toInt());
    font.setPixelSize(json["pixelSize"].toInt());
    font.setWeight(json["weight"].toInt());
    font.setOverline(json["overline"].toBool());
    font.setStrikeOut(json["strikeout"].toBool());
    font.setCapitalization((QFont::Capitalization)json["capitalization"].toInt());
    font.setLetterSpacing(QFont::AbsoluteSpacing, json["letterSpacing"].toDouble());
    font.setWordSpacing(json["wordSpacing"].toDouble());
    return font;
}

QJsonObject EAObjDisplay::font2Json(const QFont& font)
{
    QJsonObject json;
    json["family"] = font.family();
    json["italic"] = font.italic();
    json["underline"] = font.underline();
    json["pointSize"] = font.pointSize();
    json["pixelSize"] = font.pixelSize();
    json["weight"] = font.weight();
    json["overline"] = font.overline();
    json["strikeout"] = font.strikeOut();
    json["capitalization"] = font.capitalization();
    json["letterSpacing"] = font.letterSpacing();
    json["wordSpacing"] = font.wordSpacing();
    return json;
}

int EAObjDisplay::textStyle() const
{
    return m_textStyle;
}

QColor EAObjDisplay::styleColour() const
{
    return m_styleColour;
}

int EAObjDisplay::borderWidth() const
{
    return m_borderWidth;
}

int EAObjDisplay::xText() const
{
    return m_xText;
}

int EAObjDisplay::yText() const
{
    return m_yText;
}

int EAObjDisplay::vAlignment() const
{
    return m_vAlignment;
}

int EAObjDisplay::hAlignment() const
{
    return m_hAlignment;
}

QColor EAObjDisplay::backColour() const
{
    return m_backColour;
}

QColor EAObjDisplay::highlitedColour() const
{
    return m_highlitedColour;
}

int EAObjDisplay::displayType() const
{
    return m_displayType;
}

bool EAObjDisplay::whiteIcons() const
{
    return m_whiteIcons;
}

int EAObjDisplay::imageHeight() const
{
    return m_imageHeight;
}

int EAObjDisplay::xImage() const
{
    return m_xImage;
}

int EAObjDisplay::yImage() const
{
    return m_yImage;
}

int EAObjDisplay::imageWidth() const
{
    return m_imageWidth;
}

QColor EAObjDisplay::fontColour() const
{
    return m_fontColour;
}

int EAObjDisplay::x() const
{
    return m_x;
}

int EAObjDisplay::y() const
{
    return m_y;
}

int EAObjDisplay::width() const
{
    return m_width;
}

int EAObjDisplay::height() const
{
    return m_height;
}

QColor EAObjDisplay::colour() const
{
    return m_colour;
}

QColor EAObjDisplay::borderColour() const
{
    return m_borderColour;
}

int EAObjDisplay::radius() const
{
    return m_radius;
}

QFont EAObjDisplay::font() const
{
    return m_font;
}

void EAObjDisplay::setX(int x)
{
    if (m_x == x)
        return;

    m_x = x;
    emit xChanged(x);
}

void EAObjDisplay::setY(int y)
{
    if (m_y == y)
        return;

    m_y = y;
    emit yChanged(y);
}

void EAObjDisplay::setWidth(int width)
{
    if (m_width == width)
        return;

    m_width = width;
    emit widthChanged(width);
}

void EAObjDisplay::setHeight(int height)
{
    if (m_height == height)
        return;

    m_height = height;
    emit heightChanged(height);
}

void EAObjDisplay::setColour(QColor colour)
{
    if (m_colour == colour)
        return;

    m_colour = colour;
    emit colourChanged(colour);
}

void EAObjDisplay::setBorderColour(QColor borderColour)
{
    if (m_borderColour == borderColour)
        return;

    m_borderColour = borderColour;
    emit borderColourChanged(borderColour);
}

void EAObjDisplay::setRadius(int radius)
{
    if (m_radius == radius)
        return;

    m_radius = radius;
    emit radiusChanged(radius);
    emit displayParamtersChanged();
}

void EAObjDisplay::setFont(QFont font)
{
    if (m_font == font)
        return;

    m_font = font;
    emit fontChanged(font);
}

void EAObjDisplay::setFontColour(QColor fontColour)
{
    if (m_fontColour == fontColour)
        return;

    m_fontColour = fontColour;
    emit fontColourChanged(fontColour);
}

void EAObjDisplay::setTextStyle(int textStyle)
{
    if (m_textStyle == textStyle)
        return;

    m_textStyle = textStyle;
    emit textStyleChanged(textStyle);
}

void EAObjDisplay::setStyleColour(QColor styleColour)
{
    if (m_styleColour == styleColour)
        return;

    m_styleColour = styleColour;
    emit styleColourChanged(styleColour);
}

void EAObjDisplay::setBorderWidth(int borderWidth)
{
    if (m_borderWidth == borderWidth)
        return;

    m_borderWidth = borderWidth;
    emit borderWidthChanged(borderWidth);
}

void EAObjDisplay::setXText(int xText)
{
    if (m_xText == xText)
        return;

    m_xText = xText;
    emit xTextChanged(xText);
}

void EAObjDisplay::setYText(int yText)
{
    if (m_yText == yText)
        return;

    m_yText = yText;
    emit yTextChanged(yText);
}

void EAObjDisplay::setVAlignment(int verticalAlignment)
{
    if (m_vAlignment == verticalAlignment)
        return;

    m_vAlignment = verticalAlignment;
    emit vAlignmentChanged(verticalAlignment);
}

void EAObjDisplay::setHAlignment(int horizontalAlignment)
{
    if (m_hAlignment == horizontalAlignment)
        return;

    m_hAlignment = horizontalAlignment;
    emit hAlignmentChanged(horizontalAlignment);
}

void EAObjDisplay::setBackColour(QColor backColour)
{
    if (m_backColour == backColour)
        return;

    m_backColour = backColour;
    emit backColourChanged(backColour);
}

void EAObjDisplay::setHighlitedColour(QColor highlitedBackColour)
{
    if (m_highlitedColour == highlitedBackColour)
        return;

    m_highlitedColour = highlitedBackColour;
    emit highlitedColourChanged(highlitedBackColour);
}

void EAObjDisplay::setDisplayType(int displayType)
{
    if (m_displayType == displayType)
        return;

    m_displayType = displayType;
    emit displayTypeChanged(displayType);
}

void EAObjDisplay::setWhiteIcons(bool whiteIcons)
{
    if (m_whiteIcons == whiteIcons)
        return;

    m_whiteIcons = whiteIcons;
    emit whiteIconsChanged(whiteIcons);
}

void EAObjDisplay::setImageHeight(int imageHeight)
{
    if (m_imageHeight == imageHeight)
        return;

    m_imageHeight = imageHeight;
    emit imageHeightChanged(imageHeight);
}

void EAObjDisplay::setXImage(int xImage)
{
    if (m_xImage == xImage)
        return;

    m_xImage = xImage;
    emit xImageChanged(xImage);
}

void EAObjDisplay::setYImage(int yImage)
{
    if (m_yImage == yImage)
        return;

    m_yImage = yImage;
    emit yImageChanged(yImage);
}

void EAObjDisplay::setImageWidth(int imageWidth)
{
    if (m_imageWidth == imageWidth)
        return;

    m_imageWidth = imageWidth;
    emit imageWidthChanged(imageWidth);
}
