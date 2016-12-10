#include <QJsonArray>
#include <QJsonValue>

#include "eaitemlistbase.h"

EAItemListBase::EAItemListBase()
{

}

EAItemListBase::EAItemListBase(const QString &name)
    : m_listName(name)
{

}

void EAItemListBase::clear(QQmlEngine *engine)
//void EAItemListBase::clear(EAContainer* eacontainer)
{
    //setContainer(eacontainer);
    //m_engine = engine;
}

void EAItemListBase::read(const QJsonObject &json, QQmlEngine *engine)
//void EAItemListBase::read(const QJsonObject &json, EAContainer *eacontainer)
{
    setListName(json["listName"].toString());
    //setContainer(eacontainer);
    //m_engine = engine;
}

void EAItemListBase::write(QJsonObject &json) const
{
    json["listName"] = listName();
}

QString EAItemListBase::listName() const
{
    return m_listName;
}

void EAItemListBase::setListName(QString listName)
{
    if (m_listName == listName)
        return;

    m_listName = listName;
    emit listNameChanged(listName);
}

EAContainer *EAItemListBase::getContainer() const
{
    return container;
}

void EAItemListBase::setContainer(EAContainer *value)
{
    container = value;
}
/*
void EAItemListBase::setEngine(QQmlEngine *engine)
{
    m_engine = engine;
}
*/
