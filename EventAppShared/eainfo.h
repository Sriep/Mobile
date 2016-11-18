#ifndef EVENTINFO_H
#define EVENTINFO_H

#include <QQuickItem>
#include "eventappshared_global.h"
class EVENTAPPSHAREDSHARED_EXPORT EAInfo : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString eventName READ eventName WRITE setEventName NOTIFY eventNameChanged)
    Q_PROPERTY(QString eventDescription READ eventDescription WRITE setEventDescription NOTIFY eventDescriptionChanged)
    Q_PROPERTY(QString organiserName READ organiserName WRITE setOrganiserName NOTIFY organiserNameChanged)
    Q_PROPERTY(QString organiserDescription READ organiserDescription WRITE setOrganiserDescription NOTIFY organiserDescriptionChanged)


    QString m_eventName = QString(tr("Landlord Law Conference 2017"));
    QString m_eventDescription = QString(tr("If you want solid legal training"
            "for you and your staff - look no further. We have 10 legal"
            " talks, all from specialist lawyers and trainers to make sure"
            "you are bang up to date with the law."));
    QString m_organiserName = "Tessa Shepperson";
    QString m_organiserDescription = "Tessa Shepperson";

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
