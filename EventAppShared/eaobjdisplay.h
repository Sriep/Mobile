#ifndef EAOBJDISPLAY_H
#define EAOBJDISPLAY_H
#include <QColor>
#include <QFont>
#include <QQuickItem>
#include <QJsonObject>

class EAObjDisplay : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(int x READ x WRITE setX NOTIFY xChanged)
    Q_PROPERTY(int y READ y WRITE setY NOTIFY yChanged)
    Q_PROPERTY(int width READ width WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(int height READ height WRITE setHeight NOTIFY heightChanged)
    Q_PROPERTY(QColor colour READ colour WRITE setColour NOTIFY colourChanged)
    Q_PROPERTY(QColor borderColour READ borderColour WRITE setBorderColour NOTIFY borderColourChanged)
    Q_PROPERTY(int borderWidth READ borderWidth WRITE setBorderWidth NOTIFY borderWidthChanged)
    Q_PROPERTY(int radius READ radius WRITE setRadius NOTIFY radiusChanged)
    Q_PROPERTY(QFont font READ font WRITE setFont NOTIFY fontChanged)
    Q_PROPERTY(QColor fontColour READ fontColour WRITE setFontColour NOTIFY fontColourChanged)
    Q_PROPERTY(int textStyle READ textStyle WRITE setTextStyle NOTIFY textStyleChanged)
    Q_PROPERTY(QColor styleColour READ styleColour WRITE setStyleColour NOTIFY styleColourChanged)

    int m_x = 2;
    int m_y = 2;
    int m_width = 4;
    int m_height = 4;
    QColor m_colour = "ivory";
    QColor m_borderColour = "orange";
    int m_radius = 5;
    QFont m_font;
    QColor m_fontColour;
    int m_textStyle;
    QColor m_styleColour;

    int m_borderWidth;

public:
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
};

#endif // EAOBJDISPLAY_H
