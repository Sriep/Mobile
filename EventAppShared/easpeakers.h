#ifndef EASPEAKERS_H
#define EASPEAKERS_H
#include <QJsonObject>
#include <QJsonArray>
#include <QQuickItem>
#include <QStringList>
#include <QChar>
#include <QSet>

class EAListModel;
static const char seperator = ',';
static const char textDelimiter = '"';

class EASpeakers : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString titleFields READ titleFields WRITE setTitleFields NOTIFY titleFieldsChanged)
    Q_PROPERTY(QString dataList READ dataList WRITE setDataList NOTIFY dataListChanged)

    Q_PROPERTY(EAListModel* listModal READ listModal WRITE setListModal NOTIFY listModalChanged)

public:
    EASpeakers();

    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;

    Q_INVOKABLE void readCSV(const QString filename);
    //Q_INVOKABLE void constructModel();

    QString titleFields() const;
    EAListModel* listModal() const;    
    QString dataList() const;

signals:
    void titleFieldsChanged(QString titleFields);
    void listModalChanged(EAListModel* listModal);    
    void dataListChanged(QString dataList);

public slots:
    void setTitleFields(QString titleFields);
    void setTitleFields(const QJsonArray& titleFields);
    void setListModal(EAListModel* listModal);    
    void setDataList(QString dataList);
    void setDataList(const QJsonArray& dataListArray);
private:
    void addHeaderFields(const QStringList &fields);
    QJsonObject newDataItem(const QStringList &speakerData
                            , const QStringList &header);

    QJsonArray jsonFields;
    QJsonArray jsonData;
    //QJsonArray jsonListData;
    QSet<QString> fieldsSet;
    //QStringList fieldList;
    int nextIndex = 0;

    QString m_titleFields;
    EAListModel* m_listModal;
    QString m_dataList;
};

#endif // EASPEAKERS_H
