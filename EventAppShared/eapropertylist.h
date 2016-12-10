#ifndef EAPROPERTYLIST_H
#define EAPROPERTYLIST_H

#include <QJsonObject>
#include <QQuickItem>
#include <QString>

class EAPropertyList : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString properties READ properties WRITE setProperties NOTIFY propertiesChanged)

    QString m_properties;

public:
    EAPropertyList();

    QString properties() const;

    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;
signals:

    void propertiesChanged(QString properties);

public slots:
void setProperties(QString properties);
};

#endif // EAPROPERTYLIST_H
