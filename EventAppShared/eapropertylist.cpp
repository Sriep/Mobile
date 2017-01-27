#include <QJsonDocument>
#include <QByteArray>
#include "eapropertylist.h"

EAPropertyList::EAPropertyList()
{

}

QString EAPropertyList::properties() const
{
    return m_properties;
}

void EAPropertyList::read(const QJsonObject &json)
{
    QJsonDocument jsonDoc(json);
    QByteArray jsonBA(jsonDoc.toJson());
    QString jsonStr(jsonBA);
    setProperties(jsonStr);
}

void EAPropertyList::write(QJsonObject &json) const
{
    QByteArray jsonBA(properties().toUtf8());
    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonBA);
    json = jsonDoc.object();
}

void EAPropertyList::setProperties(QString properties)
{
    if (m_properties == properties)
        return;

    m_properties = properties;
    emit propertiesChanged(properties);
}
