#ifndef EASPEAKERS_H
#define EASPEAKERS_H
#include <QJsonObject>
#include <QJsonArray>
#include <QQuickItem>
#include <QStringList>
#include <QChar>
#include <QSet>

static const char seperator = ',';
static const char textDelimiter = '"';

class EASpeakers : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString titleFields READ titleFields WRITE setTitleFields NOTIFY titleFieldsChanged)
    Q_PROPERTY(QString dataList READ dataList WRITE setDataList NOTIFY dataListChanged)

public:
    EASpeakers();

    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;

    Q_INVOKABLE bool readCSV(const QString filename);

    QString titleFields() const;
    QString dataList() const;

signals:
    void titleFieldsChanged(QString titleFields);  
    void dataListChanged(QString dataList);

public slots:
    void setTitleFields(QString titleFields);
    void setTitleFields(const QJsonArray& titleFields); 
    void setDataList(QString dataList);
    void setDataList(const QJsonArray& dataListArray);
private:
    QStringList addHeaderFields(const QStringList &fields);
    QJsonObject newDataItem(const QStringList &speakerData
                            , const QStringList &header);
    QString listModelFromJson() const;
    QString getModelName(const QString& name) const;

    QJsonArray jsonFields;
    QJsonArray jsonData;

    QSet<QString> fieldsSet;
    int nextIndex = 0;

    QString m_titleFields;
    QString m_dataList;
};

#endif // EASPEAKERS_H
