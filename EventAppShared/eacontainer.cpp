#include <QJsonDocument>
#include <QIODevice>
#include <QJsonObject>
#include <QFileInfo>
#include <QDir>
#include <QDebug>



#include "eacontainer.h"
#include "eainfo.h"
#include "eaconstruction.h"
#include "eaitemlist.h"

EAContainer::EAContainer()
{
}

void EAContainer::classBegin()
{
    // Perform some initialization here now that the object is fully created
}

void EAContainer::componentComplete()
{
    // Perform some initialization here now that the object is fully created
    //loadEventApp();
    //emit eaComponentComplete();
}

void EAContainer::insertEmptyItemList(int index, QString name)
{
    EAItemList* newItemList = new EAItemList(name);
    m_eaItemLists.insert(index, newItemList);
    emit eaItemListsChanged();
}

void EAContainer::deleteItemList(int index)
{
    if (index < m_eaItemLists.count())
    {
        m_eaItemLists.removeAt(index);
        emit eaItemListsChanged();
    }
}

void EAContainer::clearEvent()
{
    m_eaInfo  = new EAInfo();
    m_dataFilename = "NewEvent";
    m_eaConstruction = new EAConstruction();
    //clearPhotos();
    m_eaItemLists.clear();
    m_eaSpeakers = new EAItemList();
}

void EAContainer::clearPhotos() const
{
    QString pwd = QDir::currentPath();
    QDir dir(pwd);
    dir.setNameFilters(QStringList() << "*.png");
    dir.setFilter(QDir::Files);
    foreach(QString dirFile, dir.entryList())
    {
        dir.remove(dirFile);
    }
}

EAInfo *EAContainer::eaInfo() const
{
    return m_eaInfo;
}

QString EAContainer::dataFilename() const
{
    return m_dataFilename;
}


bool EAContainer::loadNewEventApp(const QString &filename)
{
    clearEvent();
    setDataFilename(filename);
    return loadEventApp();
}

bool EAContainer::loadEventApp()
{
    QString pwd = QDir::currentPath();
    qDebug() << "Current working directory" << pwd;

    QFile loadFile(isSaveJson()
                   ? QString(dataFilename() + ".json")
                   : QString(dataFilename() + ".dat"));

    if (!loadFile.open(QIODevice::ReadOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QByteArray saveData = loadFile.readAll();

    QJsonDocument loadDoc(isSaveJson()
        ? QJsonDocument::fromJson(saveData)
        : QJsonDocument::fromBinaryData(saveData));

    read(loadDoc.object());
    qDebug() << "EAContainer::loadEventApp finished";
    emit eaItemListsChanged();
   // m_eaInfo->setEventName(pwd);
    return true;
}

bool EAContainer::saveEventApp(const QString& filename)
{
    if (filename != "")
        setDataFilename(filename);

    QFile saveFile(isSaveJson()
                   ? QString(dataFilename() + ".json")
                   : QString(dataFilename() + ".dat"));
    //QFile saveFile(dataFilename());

    if (!saveFile.open(QIODevice::WriteOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QJsonObject containerObject;
    write(containerObject);
    QJsonDocument saveDoc(containerObject);
    saveFile.write(isSaveJson()
        ? saveDoc.toJson()
        : saveDoc.toBinaryData());
    return true;
}

void EAContainer::read(const QJsonObject &json)
{
    setDataFilename(json["dataFilename"].toString());

    m_eaInfo->read(json["event"].toObject());
    emit eaInfoChanged(m_eaInfo);

    if (json.contains("construction"))
    {
        m_eaConstruction->read(json["construction"].toObject());
        emit eaConstructionChanged(m_eaConstruction);
    }

    QQmlEngine*  engine = qmlEngine(this);
    QJsonArray listsArray = json["itemLists"].toArray();
    for (int i = 0; i < listsArray.size(); ++i) {
        QJsonObject readJsonObject = listsArray[i].toObject();
        EAItemList* newList = new EAItemList();
        newList->read(readJsonObject, engine);
        m_eaItemLists.append(newList);
    }
    setVersion(json["version"].toInt());
}

void EAContainer::write(QJsonObject &json)
{
    json["dataFilename"] = m_dataFilename;

    QJsonObject eventInfoObject;
    m_eaInfo->write(eventInfoObject);
    json["event"] = eventInfoObject;

    QJsonObject constructionDataObject;
    m_eaConstruction->write(constructionDataObject);
    json["construction"] = constructionDataObject;

    QJsonArray listsArray;
    foreach (const EAItemList* itemList, m_eaItemLists)
    {
        {
            QJsonObject itemListObject;
            itemList->write(itemListObject);
            listsArray.append(itemListObject);
        }

    }
    json["itemLists"] = listsArray;
    json["version"] = ++m_Version;

}

EAConstruction *EAContainer::eaConstruction() const
{
    return m_eaConstruction;
}

bool EAContainer::isSaveJson() const
{
    return m_isSaveJson;
}

QString EAContainer::workingDirectory() const
{
    return m_workingDirectory;
}

EAItemList *EAContainer::eaSpeakers() const
{
    return m_eaSpeakers;
}

void EAContainer::setEAInfo(EAInfo *eventInfo)
{
    if (m_eaInfo == eventInfo)
        return;

    m_eaInfo = eventInfo;
    emit eaInfoChanged(eventInfo);
}

void EAContainer::setDataFilename(const QString& dataFilename)
{
    if (m_dataFilename == dataFilename)
        return;

    m_dataFilename = dataFilename;
    QFileInfo info(m_dataFilename);

    QString filename = info.completeBaseName();
    QString path = info.path();
    QString extension = info.suffix();
    m_dataFilename = filename;
    setIsSaveJson(extension == "json" || extension == "");
    QDir::setCurrent(path);
    emit dataFilenameChanged(m_dataFilename);
}

void EAContainer::setEAConstruction(EAConstruction *eventAppConstruction)
{
    if (m_eaConstruction == eventAppConstruction)
        return;

    m_eaConstruction = eventAppConstruction;
    emit eaConstructionChanged(eventAppConstruction);
}

void EAContainer::setIsSaveJson(bool isSaveJson)
{
    if (m_isSaveJson == isSaveJson)
        return;

    m_isSaveJson = isSaveJson;
    emit isSaveJsonChanged(isSaveJson);
}

void EAContainer::setWorkingDirectory(QString workingDirectory)
{
    if (m_workingDirectory == workingDirectory)
        return;

    m_workingDirectory = workingDirectory;
    emit workingDirectoryChanged(workingDirectory);
}

void EAContainer::setEaSpeakers(EAItemList *eaSpeakers)
{
    if (m_eaSpeakers == eaSpeakers)
        return;

    m_eaSpeakers = eaSpeakers;
    emit eaSpeakersChanged(eaSpeakers);
}

void EAContainer::setVersion(int Version)
{
    if (m_Version == Version)
        return;

    m_Version = Version;
    emit versionChanged(Version);
}

QQmlListProperty<EAItemList> EAContainer::eaItemLists()
{
    return QQmlListProperty<EAItemList>(this
                                        , 0 // void *data
                                        , &EAContainer::append_eaItemLists
                                        , &EAContainer::count_eaItemLists
                                        , &EAContainer::at_eaItemLists
                                        , &EAContainer::clear_eaItemLists
                                        );
}

int EAContainer::version() const
{
    return m_Version;
}

//typedef QQmlListProperty::AppendFunction
//Synonym for void (*)(QQmlListProperty<T> *property, T *value).
//Append the value to the list property.
void EAContainer::append_eaItemLists(QQmlListProperty<EAItemList> *list
                                     , EAItemList *itemList)
{
    EAContainer *eaContainer = qobject_cast<EAContainer *>(list->object);
    if (itemList) {
        //itemList->setParentItem(eaContainer); //???
        eaContainer->m_eaItemLists.append(itemList);
    }
}

//typedef QQmlListProperty::CountFunction
//Synonym for int (*)(QQmlListProperty<T> *property).
//Return the number of elements in the list property.
int EAContainer::count_eaItemLists(QQmlListProperty<EAItemList> *list)
{
    EAContainer *eaContainer = qobject_cast<EAContainer *>(list->object);
    return eaContainer->m_eaItemLists.count();
}

//typedef QQmlListProperty::AtFunction
//Synonym for T *(*)(QQmlListProperty<T> *property, int index).
//Return the element at position index in the list property.
EAItemList* EAContainer::at_eaItemLists(QQmlListProperty<EAItemList> *list
                                        , int index)
{
    EAContainer *eaContainer = qobject_cast<EAContainer *>(list->object);
    return eaContainer->m_eaItemLists[index];
}

//typedef QQmlListProperty::ClearFunction
//Synonym for void (*)(QQmlListProperty<T> *property).
//Clear the list property.
void EAContainer::clear_eaItemLists(QQmlListProperty<EAItemList> *list)
{
    EAContainer *eaContainer = qobject_cast<EAContainer *>(list->object);
    eaContainer->m_eaItemLists.clear();
}
























