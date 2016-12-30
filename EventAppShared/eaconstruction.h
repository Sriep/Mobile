#ifndef EVENTAPPCONSTRUCTION_H
#define EVENTAPPCONSTRUCTION_H
#include <QColor>
#include <QFont>
#include <QQuickItem>
#include "eventappshared_global.h"
#include "eaobjdisplay.h"

class  EAConstruction : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QColor backColour READ backColour WRITE setBackColour NOTIFY backColourChanged)
    Q_PROPERTY(QColor foreColour READ foreColour WRITE setForeColour NOTIFY foreColourChanged)
    Q_PROPERTY(QFont font READ font WRITE setFont NOTIFY mainChanged)
    Q_PROPERTY(QColor fontColour READ fontColour WRITE setFontColour NOTIFY fontColourChanged)
    Q_PROPERTY(EAObjDisplay* display READ display WRITE setDisplay NOTIFY displayChanged)
    Q_PROPERTY(QString style READ style WRITE setStyle NOTIFY styleChanged)

    QColor m_backColour;
    QColor m_foreColour;
    QFont m_font;
    QColor m_fontColour;
    EAObjDisplay* m_display = NULL;    
    QString m_style = "Default";

public:
    EAConstruction();

    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;

    QColor backColour() const;
    QColor foreColour() const;
    QFont font() const;
    QColor fontColour() const;    
    EAObjDisplay* display() const;    
    QString style() const;

signals:

    void backColourChanged(QColor backColour);
    void foreColourChanged(QColor foreColour);
    void mainChanged(QFont font);
    void fontColourChanged(QColor fontColour);    
    void displayChanged(EAObjDisplay* display);    
    void styleChanged(QString style);

public slots:
    void setBackColour(QColor backColour);
    void setForeColour(QColor foreColour);
    void setFont(QFont font);
    void setFontColour(QColor fontColour);
    void setDisplay(EAObjDisplay* display);
    void setStyle(QString style);
};

#endif // EVENTAPPCONSTRUCTION_H
