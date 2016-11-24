#ifndef EASPEAKERS_H
#define EASPEAKERS_H
#include <QJsonObject>
#include <QJsonArray>
#include <QQuickItem>
#include <QStringList>
#include <QSet>

class EAListModel;
static const char seperator = ',';
static const char textDelimiter = '"';

class EASpeakers : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString delegateList READ delegateList WRITE setDelegateList NOTIFY delegateListChanged)
    Q_PROPERTY(EAListModel* listModal READ listModal WRITE setListModal NOTIFY listModalChanged)

public:
    EASpeakers();

    void read(const QJsonObject &json);
    Q_INVOKABLE void readCSV(const QString filename);
    void write(QJsonObject &json) const;

    QString delegateList() const;
    EAListModel* listModal() const;

signals:

    void delegateListChanged(QString delegateList);

    void listModalChanged(EAListModel* listModal);

public slots:
    void setDelegateList(QString delegateList);
    void setListModal(EAListModel* listModal);

private:
    void addHeaderFields(const QList<QByteArray>& fields);
    QJsonObject newDataItem(const QList<QByteArray> &speakerData
                            , const QList<QByteArray> &header);

    QJsonArray jsonFields;
    QJsonArray jsonListData;
    QSet<QString> fieldsSet;

    QString m_delegateList;
    EAListModel* m_listModal;
};

#endif // EASPEAKERS_H
