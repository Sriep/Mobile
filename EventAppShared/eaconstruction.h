#ifndef EVENTAPPCONSTRUCTION_H
#define EVENTAPPCONSTRUCTION_H
#include <QColor>
#include <QFont>
#include <QQuickItem>
#include "eventappshared_global.h"
#include "eaobjdisplay.h"
#include "eastrings.h"

class  EAConstruction : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QColor backColour READ backColour WRITE setBackColour NOTIFY backColourChanged)
    Q_PROPERTY(QColor foreColour READ foreColour WRITE setForeColour NOTIFY foreColourChanged)
    Q_PROPERTY(QFont font READ font WRITE setFont NOTIFY mainChanged)
    Q_PROPERTY(QColor fontColour READ fontColour WRITE setFontColour NOTIFY fontColourChanged)    
    Q_PROPERTY(QString style READ style WRITE setStyle NOTIFY styleChanged)
    Q_PROPERTY(EAObjDisplay* display READ display WRITE setDisplay NOTIFY displayChanged)
    Q_PROPERTY(EAObjDisplay* toolBarDisplay READ toolBarDisplay WRITE setToolBarDisplay NOTIFY toolBarDisplayChanged)
    Q_PROPERTY(EAObjDisplay* menuDisplay READ menuDisplay WRITE setMenuDisplay NOTIFY menuDisplayChanged)
    Q_PROPERTY(EAStrings* strings READ strings WRITE setStrings NOTIFY stringsChanged)

    QColor m_backColour;
    QColor m_foreColour;
    QFont m_font;
    QColor m_fontColour;
    EAObjDisplay* m_display = NULL;    
    QString m_style = "Default";    
    EAObjDisplay* m_toolBarDisplay;
    EAObjDisplay* m_menuDisplay;    
    EAStrings* m_strings;

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
    EAObjDisplay* toolBarDisplay() const;
    EAObjDisplay* menuDisplay() const;    
    EAStrings* strings() const;

signals:

    void backColourChanged(QColor backColour);
    void foreColourChanged(QColor foreColour);
    void mainChanged(QFont font);
    void fontColourChanged(QColor fontColour);    
    void displayChanged(EAObjDisplay* display);    
    void styleChanged(QString style);    
    void toolBarDisplayChanged(EAObjDisplay* toolBarDisplay);
    void menuDisplayChanged(EAObjDisplay* menuDisplay);    
    void stringsChanged(EAStrings* strings);

public slots:
    void setBackColour(QColor backColour);
    void setForeColour(QColor foreColour);
    void setFont(QFont font);
    void setFontColour(QColor fontColour);
    void setDisplay(EAObjDisplay* display);
    void setStyle(QString style);
    void setToolBarDisplay(EAObjDisplay* toolBarDisplay);
    void setMenuDisplay(EAObjDisplay* menuDisplay);
    void setStrings(EAStrings* strings);
};

#endif // EVENTAPPCONSTRUCTION_H
