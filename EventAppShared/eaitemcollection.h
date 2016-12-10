#ifndef EAITEMCOLLECTION_H
#define EAITEMCOLLECTION_H
#include <QString>
#include <QQmlListProperty>
#include <QJsonObject>

#include "eaitem.h"
#include "eaitemlistbase.h"


class EAItemCollection : public EAItemListBase
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<EAItem> items READ itemList)

    QList<EAItem*> m_eaItems;
public:

    EAItemCollection();
    EAItemCollection(const QString name);

    virtual void read(const QJsonObject &json, QQmlEngine* engine);
    virtual void write(QJsonObject &json) const;

    QQmlListProperty<EAItem> itemList() const;

private:
    static void append_eaItems(QQmlListProperty<EAItem> *list
                                   , EAItem *itemList);
    static int count_eaItems(QQmlListProperty<EAItem> *list);
    static EAItem* at_eaItems(QQmlListProperty<EAItem> *list
                                      , int index);
    static void clear_eaItems(QQmlListProperty<EAItem> *list);
    QQmlListProperty<EAItem> m_items;
};

#endif // EAITEMCOLLECTION_H
