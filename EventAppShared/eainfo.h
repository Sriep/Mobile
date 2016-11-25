#ifndef EVENTINFO_H
#define EVENTINFO_H

#include <QQuickItem>
#include "eventappshared_global.h"
class  EAInfo : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString eventName READ eventName WRITE setEventName NOTIFY eventNameChanged)
    Q_PROPERTY(QString eventDescription READ eventDescription WRITE setEventDescription NOTIFY eventDescriptionChanged)
    Q_PROPERTY(QString organiserName READ organiserName WRITE setOrganiserName NOTIFY organiserNameChanged)
    Q_PROPERTY(QString organiserDescription READ organiserDescription WRITE setOrganiserDescription NOTIFY organiserDescriptionChanged)


    QString m_eventName;
    QString m_eventDescription;
    QString m_organiserName;
    QString m_organiserDescription;

public:
    EAInfo();

    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;

    QString eventName() const;
    QString eventDescription() const;
    QString organiserName() const;
    QString organiserDescription() const;

signals:

    void eventNameChanged(QString eventName);
    void eventDescriptionChanged(QString eventDescription);
    void organiserNameChanged(QString organiserName);
    void organiserDescriptionChanged(QString organiserDescription);

public slots:
    void setEventName(QString eventName);
    void setEventDescription(QString eventDescription);
    void setOrganiserName(QString organiserName);
    void setOrganiserDescription(QString organiserDescription);
};

#endif // EVENTINFO_H
