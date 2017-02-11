#ifndef EAOBJDISPLAY_H
#define EAOBJDISPLAY_H
#include <QColor>
#include <QFont>
#include <QQuickItem>
#include <QJsonObject>

static const int AlignLeft = 1;
static const int AlignRight = 2;
static const int AlignHCenter = 4;
static const int AlignJustify = 8;
static const int AlignTop = 32;
static const int AlignBottom = 64;
static const int AlignVCenter = 128;

class EAObjDisplay : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(int x READ x WRITE setX NOTIFY xChanged)
    Q_PROPERTY(int y READ y WRITE setY NOTIFY yChanged)
    Q_PROPERTY(int width READ width WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(int height READ height WRITE setHeight NOTIFY heightChanged)
    Q_PROPERTY(QColor backColour READ backColour WRITE setBackColour NOTIFY backColourChanged)

    Q_PROPERTY(int radius READ radius WRITE setRadius NOTIFY radiusChanged)
    Q_PROPERTY(QColor borderColour READ borderColour WRITE setBorderColour NOTIFY borderColourChanged)
    Q_PROPERTY(int borderWidth READ borderWidth WRITE setBorderWidth NOTIFY borderWidthChanged)

    Q_PROPERTY(int imageHeight READ imageHeight WRITE setImageHeight NOTIFY imageHeightChanged)
    Q_PROPERTY(int xImage READ xImage WRITE setXImage NOTIFY xImageChanged)
    Q_PROPERTY(int yImage READ yImage WRITE setYImage NOTIFY yImageChanged)

    Q_PROPERTY(QFont font READ font WRITE setFont NOTIFY fontChanged)
    Q_PROPERTY(QColor fontColour READ fontColour WRITE setFontColour NOTIFY fontColourChanged)
    Q_PROPERTY(int textStyle READ textStyle WRITE setTextStyle NOTIFY textStyleChanged)
    Q_PROPERTY(QColor styleColour READ styleColour WRITE setStyleColour NOTIFY styleColourChanged)
    Q_PROPERTY(int xText READ xText WRITE setXText NOTIFY xTextChanged)
    Q_PROPERTY(int yText READ yText WRITE setYText NOTIFY yTextChanged)
    Q_PROPERTY(int vAlignment READ vAlignment WRITE setVAlignment NOTIFY vAlignmentChanged)
    Q_PROPERTY(int hAlignment READ hAlignment WRITE setHAlignment NOTIFY hAlignmentChanged)

    Q_PROPERTY(QColor colour READ colour WRITE setColour NOTIFY colourChanged)
    Q_PROPERTY(QColor highlitedColour READ highlitedColour WRITE setHighlitedColour NOTIFY highlitedColourChanged)

    Q_PROPERTY(bool whiteIcons READ whiteIcons WRITE setWhiteIcons NOTIFY whiteIconsChanged)
    Q_PROPERTY(int displayType READ displayType WRITE setDisplayType NOTIFY displayTypeChanged)


    int m_x = 2;
    int m_y = 2;
    int m_width = 4;
    int m_height = 40;
    QColor m_colour = "ivory";
    QColor m_borderColour = "orange";
    int m_radius = 5;
    QFont m_font;
    QColor m_fontColour;
    int m_textStyle = 0;
    QColor m_styleColour;
    int m_borderWidth = 0;
    int m_xText = 5;
    int m_yText = 5;
    int m_vAlignment = AlignRight;
    int m_hAlignment = AlignVCenter;    
    QColor m_backColour;    
    QColor m_highlitedColour;    
    int m_displayType;
    bool m_whiteIcons;    
    int m_imageHeight;
    int m_xImage;    
    int m_yImage;

public:
    enum DisplayType { Menu=0, Toolbar, Drawer };
    Q_ENUM(DisplayType)

    EAObjDisplay();

    void read(const QJsonObject &json);
    void write(QJsonObject &json);
    int x() const;
    int y() const;
    int width() const;
    int height() const;
    QColor colour() const;
    QColor borderColour() const;
    int radius() const;
    QFont font() const;
    QColor fontColour() const;
    QFont json2Font(const QJsonObject& json);
    QJsonObject font2Json(const QFont& font);    
    int textStyle() const;
    QColor styleColour() const;
    int borderWidth() const;    
    int xText() const;
    int yText() const;
    int vAlignment() const;
    int hAlignment() const;    
    QColor backColour() const;    
    QColor highlitedColour() const;    
    int displayType() const;
    bool whiteIcons() const;    
    int imageHeight() const;
    int xImage() const;    
    int yImage() const;

signals:
    void xChanged(int x);
    void yChanged(int y);
    void widthChanged(int width);
    void heightChanged(int height);
    void colourChanged(QColor colour);
    void borderColourChanged(QColor borderColour);
    void radiusChanged(int radius);
    void fontChanged(QFont font);
    void fontColourChanged(QColor fontColour);
    void textStyleChanged(int textStyle);
    void styleColourChanged(QColor styleColour);
    void borderWidthChanged(int borderWidth);    
    void xTextChanged(int xText);
    void yTextChanged(int yText);
    void vAlignmentChanged(int vAlignment);
    void hAlignmentChanged(int hAlignment);
    void displayParamtersChanged();    
    void backColourChanged(QColor backColour);    
    void highlitedColourChanged(QColor highlitedColour);    
    void displayTypeChanged(int displayType);
    void whiteIconsChanged(bool whiteIcons);    
    void imageHeightChanged(int imageHeight);
    void xImageChanged(int xImage);    
    void yImageChanged(int yImage);

public slots:
    void setX(int x);
    void setY(int y);
    void setWidth(int width);
    void setHeight(int height);
    void setColour(QColor colour);
    void setBorderColour(QColor borderColour);
    void setRadius(int radius);
    void setFont(QFont font);
    void setFontColour(QColor fontColour);
    void setTextStyle(int textStyle);
    void setStyleColour(QColor styleColour);
    void setBorderWidth(int borderWidth);
    void setXText(int xText);
    void setYText(int yText);
    void setVAlignment(int vAlignment);
    void setHAlignment(int hAlignment);
    void setBackColour(QColor backColour);
    void setHighlitedColour(QColor highlitedColour);
    void setDisplayType(int displayType);
    void setWhiteIcons(bool whiteIcons);
    void setImageHeight(int imageHeight);
    void setXImage(int xImage);
    void setYImage(int yImage);
};

#endif // EAOBJDISPLAY_H
