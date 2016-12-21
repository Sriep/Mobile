#ifndef EAUSERS_H
#define EAUSERS_H

#include <QQuickItem>

class EAUsers : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString user READ user WRITE setUser NOTIFY userChanged)
    Q_PROPERTY(int index READ index WRITE setIndex NOTIFY indexChanged)
    QString m_user;
    int m_index;

public:
    EAUsers();

    QString user() const;
    int index() const;

signals:

    void userChanged(QString user);
    void indexChanged(int index);

public slots:
    void setUser(QString user);
    void setIndex(int index);
};

#endif // EAUSERS_H
