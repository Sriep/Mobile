#ifndef EAITEMLISTBASE_H
#define EAITEMLISTBASE_H
#include <QJsonObject>
#include <QQuickItem>
#include <QQmlEngine>

#include "eacontainer.h"

class EAItemListBase : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString listName READ listName WRITE setListName NOTIFY listNameChanged)

public:
    EAItemListBase();
    EAItemListBase(const QString& name);

    //virtual void read(const QJsonObject &json, QQmlEngine* engine = NULL);
    virtual void read(const QJsonObject &json, QQmlEngine* engine = NULL);
    virtual void write(QJsonObject &json) const;
    virtual void clear(QQmlEngine *engine);
    //virtual void clear(EAContainer* eacontainer);
    QString listName() const;

    //void setEngine(QQmlEngine *engine);

    EAContainer *getContainer() const;
    void setContainer(EAContainer *value);

signals:

    void listNameChanged(QString listName);

public slots:
    void setListName(QString listName);
protected:
     //QQmlEngine* m_engine;
     EAContainer* container;
private:
     QString m_listName;


};

#endif // EAITEMLISTBASE_H
