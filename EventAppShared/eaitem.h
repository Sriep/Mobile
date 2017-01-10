#ifndef EAITEM_H
#define EAITEM_H
#include <QJsonObject>
#include <QQuickItem>
#include <QUrl>
#include "eaquestion.h"
#include "eacontainer.h"

class EAItemList;
class EAUser;
class EAItem : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(int itemType READ itemType WRITE setItemType NOTIFY itemTypeChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)

    //Q_PROPERTY(QString filename READ filename WRITE setFilename NOTIFY filenameChanged)
    Q_PROPERTY(QString displayText READ displayText WRITE setDisplayText NOTIFY displayTextChanged)
    Q_PROPERTY(QUrl url READ url WRITE setUrl NOTIFY urlChanged)
    Q_PROPERTY(QString urlString READ urlString WRITE setUrlString NOTIFY urlStringChanged)
    Q_PROPERTY(QQmlListProperty<EaQuestion> questions READ questions)

public:
    enum ItemType { Image=0, Document, Url, Questions };
    Q_ENUM(ItemType)
   // enum ListType { FromCsv=0, Manual, Questions, Users };
    //Q_ENUM(ListType)

    EAItem();
    explicit EAItem(int itemType, const QString& title, const QString& displayText = "");
    explicit EAItem(const QString& title, const QUrl url);

    Q_INVOKABLE void addTextQuestion(const QString& questionText, int index = -1);
   // Q_INVOKABLE void saveAnswers();

    void read(const QJsonObject &json, EAItemList* eaitemList = NULL);
    void write(QJsonObject &json);
    void writeAnswers(EAUser* user, QJsonObject &json);

    int itemType() const;
    QString title() const;
    QString data() const;
    QString displayText() const;
    QUrl url() const;
    QString urlString() const;

    QQmlListProperty<EaQuestion> questions();


    EAItemList *getEaItemList() const;
    void setEaItemList(EAItemList *value);
    int getIndex();

    QList<EaQuestion *> getEaQuestions() const;
    void setEaQuestions(const QList<EaQuestion *> &eaQuestions);

signals:
    void itemTypeChanged(int itemType);
    void titleChanged(QString title);
    void DataChanged(QString data);
    void displayTextChanged(QString displayText);

    void urlChanged(QUrl url);
    void eaQuestionsChanged();
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
    static void append_eaQuestion(QQmlListProperty<EaQuestion> *list
                                   , EaQuestion *itemList);
    static int count_eaQuestion(QQmlListProperty<EaQuestion> *list);
    static EaQuestion* at_eaQuestion(QQmlListProperty<EaQuestion> *list
                                      , int index);
    static void clear_eaQuestion(QQmlListProperty<EaQuestion> *list);

    int m_itemType;
    QString m_title;
    QString m_data;
    QString m_displayText;
    EAItemList* eaItemList;

    int id = 0;
    int version = 0;
    QUrl m_url;
    QString m_urlString;
    QQmlListProperty<EaQuestion> m_questions;
    QList<EaQuestion*> m_eaQuestions;
};

#endif // EAITEM_H



































