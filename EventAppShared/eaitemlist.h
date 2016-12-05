#ifndef EAITEMLIST_H
#define EAITEMLIST_H
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QPixmap>
#include <QQuickItem>
#include <QStringList>
#include <QChar>
#include <QSet>

static const char seperator = ',';
static const char textDelimiter = '"';
static const QString emptyHeader = "{\"headerFields\":[]}";
QJsonValue jsonValFromPixmap(const QPixmap & p);
QPixmap pixmapFrom(const QJsonValue & val);

class EAItemList : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString listName READ listName WRITE setListName NOTIFY listNameChanged)
    Q_PROPERTY(QString titleFields READ titleFields WRITE setTitleFields NOTIFY titleFieldsChanged)
    Q_PROPERTY(QString dataList READ dataList WRITE setDataList NOTIFY dataListChanged)

    Q_PROPERTY(bool showPhotos READ showPhotos WRITE setShowPhotos NOTIFY showPhotosChanged)

public:
    EAItemList();
    EAItemList(QString name);

    void read(const QJsonObject &json, bool unpack);
    void write(QJsonObject &json) const;

    Q_INVOKABLE bool readCSV(const QString filename);
    Q_INVOKABLE void amendField(int index
                                , const QString& field
                                , const QString& modelName
                                , const QString& format
                                , bool inListView);
    Q_INVOKABLE void saveTitleChanges();
    Q_INVOKABLE void loadPhotos(const QString& format);

    QString titleFields() const;
    QString dataList() const;
    QString listName() const;
    bool showPhotos() const;

signals:
    void titleFieldsChanged(QString titleFields);  
    void dataListChanged(QString dataList);
    void listNameChanged(QString listName);   
    void showPhotosChanged(bool showPhotos);

public slots:
    void setTitleFields(QString titleFields);
    void setTitleFields(const QJsonArray& titleFields); 
    void setDataList(QString dataList);
    void setDataList(const QJsonArray& dataListArray);
    void setListName(QString listName);    
    void setShowPhotos(bool showPhotos);

private:
    QStringList addHeaderFields(const QStringList &fields);
    QJsonObject newDataItem(const QStringList &speakerData
                            , const QStringList &header);
    QString getModelName(const QString& name) const;
    void unpackPhotos() const;

    QJsonArray jsonFields;
    QJsonArray jsonData;
    QJsonArray jsonPictures;

    QSet<QString> fieldsSet;
    int nextIndex = 0;

    QString m_titleFields;
    QString m_dataList;
    QString m_listName;
    bool m_showPhotos;
};

#endif // EAITEMLIST_H
