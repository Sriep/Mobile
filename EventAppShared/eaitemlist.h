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
#include <QString>

#include "eaitem.h"

static const char seperator = ',';
static const char textDelimiter = '"';
static const QString emptyHeader = "{\"headerFields\":[]}";
QJsonValue jsonValFromPixmap(const QPixmap & p);
QPixmap pixmapFrom(const QJsonValue & val);
class EAContainer;



class EAItemList :  public QQuickItem //public EAItemListBase
{
    Q_OBJECT
    Q_PROPERTY(QString listName READ listName WRITE setListName NOTIFY listNameChanged)
    Q_PROPERTY(QString shortFormat READ shortFormat WRITE setShortFormat NOTIFY shortFormatChanged)
    Q_PROPERTY(QString longFormat READ longFormat WRITE setLongFormat NOTIFY longFormatChanged)
    Q_PROPERTY(bool showPhotos READ showPhotos WRITE setShowPhotos NOTIFY showPhotosChanged)
    Q_PROPERTY(QString titleFields READ titleFields WRITE setTitleFields NOTIFY titleFieldsChanged)
    Q_PROPERTY(QString dataList READ dataList WRITE setDataList NOTIFY dataListChanged)

    Q_PROPERTY(bool formatedList READ formatedList WRITE setFormatedList NOTIFY formatedListChanged)
    Q_PROPERTY(int listType READ listType WRITE setListType NOTIFY listTypeChanged)
    Q_PROPERTY(QQmlListProperty<EAItem> items READ items)
    Q_PROPERTY(bool showIcon READ showIcon WRITE setShowIcon NOTIFY showIconChanged)

public:
    //enum ListType { High, Low, VeryHigh, VeryLow };
    //enum ListType { Csv, Manual, UserNames, Schedule };
    enum ListType { Formated, Manual, UserNames, Schedule };
    Q_ENUM(ListType)

    EAItemList();
    EAItemList(const QString& name);
    virtual ~EAItemList();

    virtual void read(const QJsonObject &json
                      , EAContainer* eacontainer = NULL);
    //virtual void read(const QJsonObject &json, EAContainer* eacontainer);
    virtual void write(QJsonObject &json);
    //virtual void clear(QQmlEngine *engine);
    virtual void clear(EAContainer* eacontainer);
//resetImageProvider(getEaContainer());
    Q_INVOKABLE void loadCSV(const QString filenameUrl);
    Q_INVOKABLE void saveCSV(const QString filenameUrl);
    Q_INVOKABLE void amendField(int index
                                , const QString& field
                                , const QString& modelName
                                , const QString& format
                                , bool inListView);
    Q_INVOKABLE void saveTitleChanges();
    Q_INVOKABLE void loadPhotos(const QString& format);
    Q_INVOKABLE int insertListItem(int index
                                    , int itemType
                                    , const QString& title
                                    , const QString& imageFileUrl =""
                                    , const QString& textFilenameUrl = ""
                                    , const QString &url = "");
    Q_INVOKABLE int insertMapItem(int index
                                    , const QString& title
                                    , const QString& maptype
                                    , const QString& token
                                    , const QString& mapID
                                    , double latitude
                                    , double longitude
                                    , int zoomLevel
                                    , bool useCurrent);

    Q_INVOKABLE int updateListItem(int index
                                    , int itemType
                                    , const QString& title
                                    , const QString& imageFileUrl =""
                                    , const QString& textFilenameUrl = ""
                                    , const QString &url = "");
    Q_INVOKABLE int updateMapItem(int index
                                    , int itemType
                                    , const QString& title
                                    , const QString& maptype
                                    , const QString& token
                                    , const QString& mapID
                                    , double latitude
                                    , double longitude
                                    , int zoomLevel
                                    , bool useCurrent);

    //Q_INVOKABLE void removeItem(int index);
    Q_INVOKABLE void saveAnswers(int itemIndex);
    Q_INVOKABLE int getIndex();
    Q_INVOKABLE void deleteItem(int index);
    Q_INVOKABLE int moveItem(int index, bool directionUp);
    //Q_INVOKABLE int itemListLength();

    void resetImageProvider(EAContainer* eacontainer = NULL);
    QString titleFields() const;
    QString dataList() const;
    QString listName() const;
    bool showPhotos() const;
    QString shortFormat() const;
    QString longFormat() const;
    QQmlListProperty<EAItem> items();
    bool formatedList() const;    
    int listType() const;

    EAContainer *getEaContainer();
    void setEaContainer(EAContainer *value);

    QList<EAItem *> getEaItems() const;
    void setEaItems(const QList<EAItem *> &eaItems);    
    bool showIcon();

signals:
    void titleFieldsChanged(QString titleFields);
    void dataListChanged(QString dataList);
    void listNameChanged(QString listName);
    void showPhotosChanged(bool showPhotos);    
    void shortFormatChanged(QString shortFormat);
    void longFormatChanged(QString longFormat);
    void eaItemListChanged();
    void formatedListChanged(bool formatedList);    
    void listTypeChanged(int listType);
    void eaItemsChnged();    
    void showIconChanged(bool showIcon);

public slots:
    void setTitleFields(QString titleFields);
    void setTitleFields(const QJsonArray& titleFields); 
    void setDataList(QString dataList);
    void setDataList(const QJsonArray& dataListArray);
    void setListName(QString listName);
    void setShowPhotos(bool showPhotos);    
    void setShortFormat(QString shortFormat);
    void setLongFormat(QString longFormat);
    void setFormatedList(bool formatedList);    
    void setListType(int listType);    
    void setShowIcon(bool showIcon);

private:
    void init();
    QStringList addHeaderFields(const QStringList &fields);
    QJsonObject newDataItem(const QStringList &speakerData
                            , const QStringList &header);
    QString getModelName(const QString& name) const;
    QString savePicture(int index, const QString &path);
    void padOutPictures();
    QList<QStringList> formatted2StringLists(const QString &imagePath);
    QList<QStringList> manual2StringLists(const QString &imagePath);
    QString saveItemFilename(int index, const QString& path);
    QStringList headerList();
    void readFormatedList(QList<QStringList> csvListLines);
    void readMixedList(QList<QStringList> listlist);
    void readNewImageItem(QStringList listlist);
    void readNewTextItem(QStringList listlist);
    void readNewUrlItem(QStringList listlist);
    void readNewMapItem(QStringList listlist);
    void readNewQuestionItem(QStringList listlist);


    //void unpackPhotos() const;
    void addPicture(int index, const QString& filename);
    int useNextItemId();

    QJsonArray jsonFields;
    QJsonArray jsonData;
    QJsonArray jsonPictures;

    QSet<QString> fieldsSet;
    int nextItemId = 0;
    int id = 0;
    int version = 0;

    QString m_titleFields;
    QString m_dataList;
    QString m_listName;
    bool m_showPhotos = false;
    QString m_shortFormat = "<html>{0}<br></html>\n";
    QString m_longFormat;
    EAContainer* eaContainer;


    static void append_eaItems(QQmlListProperty<EAItem> *list
                                   , EAItem *itemList);
    static int count_eaItems(QQmlListProperty<EAItem> *list);
    static EAItem* at_eaItems(QQmlListProperty<EAItem> *list
                                      , int index);
    static void clear_eaItems(QQmlListProperty<EAItem> *list);

    QQmlListProperty<EAItem> m_items;
    QList<EAItem*> m_eaItems;
    bool m_formatedList = true;
    int m_listType;
    bool m_showIcon;
};

#endif // EAITEMLIST_H
