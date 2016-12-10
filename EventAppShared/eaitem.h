#ifndef EAITEM_H
#define EAITEM_H
#include <QJsonObject>
#include <QQuickItem>

class EAItem : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(int itemType READ itemType WRITE setItemType NOTIFY itemTypeChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QString data READ data WRITE setData NOTIFY DataChanged)

    int m_itemType;
    QString m_title;
    QString m_data;

public:
    enum ItemType { Document=0, Image, ExternalUrl, Webpage };
    Q_ENUM(ItemType)

    EAItem();
    EAItem(int itemType, const QString& title, const QString& data);

    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;

    int itemType() const;
    QString title() const;
    QString data() const;

signals:
    void itemTypeChanged(int itemType);
    void titleChanged(QString title);
    void DataChanged(QString data);

public slots:
    void setItemType(int itemType);
    void setTitle(QString title);
    void setData(QString data);
};

#endif // EAITEM_H
