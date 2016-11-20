#include <QJsonDocument>
#include <QIODevice>
#include <QJsonObject>
#include <QFileInfo>
#include <QDir>

#include "eacontainer.h"
#include "eainfo.h"
#include "eaconstruction.h"

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
    loadEventApp();
    emit eaComponentComplete();
}

EAInfo *EAContainer::eaInfo() const
{
    return m_eaInfo;
}

QString EAContainer::dataFilename() const
{
    return m_dataFilename;
}

bool EAContainer::loadEventApp()
{
    //QFile loadFile(dataFilename());
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

    return true;
}

bool EAContainer::saveSaveEventApp() const
{
    QFile saveFile(isSaveJson()
                   ? QString(dataFilename() + ".json")
                   : QString(dataFilename() + ".dat"));
    //QFile saveFile(dataFilename());

    if (!saveFile.open(QIODevice::WriteOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QJsonObject gameObject;
    write(gameObject);
    QJsonDocument saveDoc(gameObject);
    saveFile.write(isSaveJson()
        ? saveDoc.toJson()
        : saveDoc.toBinaryData());

    return true;
}

void EAContainer::read(const QJsonObject &json)
{
    setDataFilename(json["dataFilename"].toString());

    QJsonObject gameDataObject = json["event"].toObject();
    m_eaInfo->read(gameDataObject);

    QJsonObject constructionDataObject = json["construction"].toObject();
    m_eaConstruction->read(constructionDataObject);
}

void EAContainer::write(QJsonObject &json) const
{
    json["dataFilename"] = m_dataFilename;

    QJsonObject eventInfoObject;
    m_eaInfo->write(eventInfoObject);
    json["event"] = eventInfoObject;

    QJsonObject constructionDataObject;
    m_eaConstruction->write(constructionDataObject);
    json["construction"] = constructionDataObject;
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

void EAContainer::setEAInfo(EAInfo *eventInfo)
{
    if (m_eaInfo == eventInfo)
        return;

    m_eaInfo = eventInfo;
    emit eaInfoChanged(eventInfo);
}

void EAContainer::setDataFilename(QString dataFilename)
{
    if (m_dataFilename == dataFilename)
        return;

    m_dataFilename = dataFilename;
    QFileInfo info(m_dataFilename);

    QString filename = info.completeBaseName();
    QString path = info.path();
    QString extension = info.suffix();
    m_dataFilename = filename;
    setIsSaveJson(extension == "json");
    QDir::setCurrent(path);
    emit dataFilenameChanged(dataFilename);
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
