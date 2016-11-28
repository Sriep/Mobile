#ifndef EAITEMLIST_H
#define EAITEMLIST_H
#include <QJsonObject>
#include <QJsonArray>
#include <QQuickItem>
#include <QStringList>
#include <QChar>
#include <QSet>

static const char seperator = ',';
static const char textDelimiter = '"';

class EAItemList : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString listName READ listName WRITE setListName NOTIFY listNameChanged)
    Q_PROPERTY(QString titleFields READ titleFields WRITE setTitleFields NOTIFY titleFieldsChanged)
    Q_PROPERTY(QString dataList READ dataList WRITE setDataList NOTIFY dataListChanged)

public:
    EAItemList();

    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;

    Q_INVOKABLE bool readCSV(const QString filename);
    Q_INVOKABLE void amendField(int index
                                , const QString& field
                                , const QString& modelName
                                , const QString& format
                                , bool inListView);
    Q_INVOKABLE void saveTitleChanges();

    QString titleFields() const;
    QString dataList() const;

    QString listName() const;

signals:
    void titleFieldsChanged(QString titleFields);  
    void dataListChanged(QString dataList);

    void listNameChanged(QString listName);

public slots:
    void setTitleFields(QString titleFields);
    void setTitleFields(const QJsonArray& titleFields); 
    void setDataList(QString dataList);
    void setDataList(const QJsonArray& dataListArray);
    void setListName(QString listName);

private:
    QStringList addHeaderFields(const QStringList &fields);
    QJsonObject newDataItem(const QStringList &speakerData
                            , const QStringList &header);
    QString getModelName(const QString& name) const;

    QJsonArray jsonFields;
    QJsonArray jsonData;

    QSet<QString> fieldsSet;
    int nextIndex = 0;

    QString m_titleFields;
    QString m_dataList;
    QString m_listName;
};

#endif // EAITEMLIST_H
