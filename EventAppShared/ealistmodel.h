#ifndef EALISTMODEL_H
#define EALISTMODEL_H
#include <QJsonObject>
#include <QQuickItem>
#include <QString>


class EAListModel : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString listName READ listName WRITE setListName NOTIFY listNameChanged)

public:
    EAListModel();
    //Q_INVOKABLE void constructModel();

    void read(const QJsonArray &jsonArray);
    void write(QJsonArray &jsonArray) const;
    void append(const QJsonArray &jsonArray);

    QString listName() const;
public slots:
    void setListName(QString listName);
signals:
    void listNameChanged(QString listName);

private:
    QStringList propertyList;

    QString m_listName;
};

#endif // EALISTMODEL_H
