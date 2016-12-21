#ifndef EAITEM_H
#define EAITEM_H
#include <QJsonObject>
#include <QQuickItem>
#include <QUrl>

class EAItem : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(int itemType READ itemType WRITE setItemType NOTIFY itemTypeChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    //Q_PROPERTY(QString filename READ filename WRITE setFilename NOTIFY filenameChanged)
    Q_PROPERTY(QString displayText READ displayText WRITE setDisplayText NOTIFY displayTextChanged)
    Q_PROPERTY(QUrl url READ url WRITE setUrl NOTIFY urlChanged)
    Q_PROPERTY(QString urlString READ urlString WRITE setUrlString NOTIFY urlStringChanged)

public:
    enum ItemType { Image=0, Document, Url };
    Q_ENUM(ItemType)
    enum ListType { FromCsv=0, Manual, FeedBackForm, Users };
    Q_ENUM(ListType)

    EAItem();
    explicit EAItem(int itemType, const QString& title, const QString& displayText = "");
    explicit EAItem(const QString& title, const QUrl url);

    void read(const QJsonObject &json);
    void write(QJsonObject &json);

    int itemType() const;
    QString title() const;
    QString data() const;

    QString displayText() const;

    QUrl url() const;

    QString urlString() const;

signals:
    void itemTypeChanged(int itemType);
    void titleChanged(QString title);
    void DataChanged(QString data);    
    void displayTextChanged(QString displayText);

    void urlChanged(QUrl url);

    void urlStringChanged(QString urlString);

public slots:
    void setItemType(int itemType);
    void setTitle(QString title);
    void setData(QString data);    
    void setDisplayText(QString displayText);

    void setUrl(QUrl url);

    void setUrlString(QString urlString);

private:
    void loadTextFile();

    int m_itemType;
    QString m_title;
    QString m_data;
    QString m_displayText;

    int id = 0;
    int version = 0;
    QUrl m_url;
    QString m_urlString;
};

#endif // EAITEM_H



































