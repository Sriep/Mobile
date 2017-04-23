#include <QJsonObject>
#include <QJsonArray>

#include "eaitem.h"
#include "eauser.h"
#include "eaquestion.h"
#include "eacontainer.h"
#include "eaitemlist.h"
#include "eamap.h"

EAItem::EAItem()
{

}

EAItem::EAItem(int itemType, const QString &title, const QString &displayText)
{
    setItemType(itemType);
    setTitle(title);
    setDisplayText(displayText);
}

EAItem::EAItem(const QString &title, const QUrl url)
{
    setItemType(ItemType::Url);
    setTitle(title);
    setUrl(url);
    setUrlString(url.toString());
}

void EAItem::read(const QJsonObject &json, EAItemList *eaitemList)
{
    eaItemList = eaitemList;

    setItemType(json["itemType"].toInt());
    setTitle(json["title"].toString());
    setDisplayText(json["displayText"].toString());
    setUrl(json["url"].toString());

    QJsonArray questionsArray = json["questions"].toArray();
    for (int i = 0; i < questionsArray.size(); ++i) {
        QJsonObject readJsonObject = questionsArray[i].toObject();
        EaQuestion* newQuestion = new EaQuestion();
        newQuestion->read(readJsonObject, this);
        m_eaQuestions.append(newQuestion);
    }

    if (json.contains("mapInfo"))
    {
        setMapInfo(new EAMap());
        mapInfo()->read(json["mapInfo"].toObject());
    }

    id = json["id"].toInt();
    version = json["version"].toInt();
}

void EAItem::write(QJsonObject &json)
{
    json["itemType"] = itemType();
    json["title"] = title();
    json["displayText"] = displayText();
    json["url"] = url().url();

    QJsonArray questionsArray;
    foreach (EaQuestion* question, m_eaQuestions)
    {
        {
            QJsonObject questionObject;
            question->write(questionObject);
            questionsArray.append(questionObject);
        }

    }
    json["questions"] = questionsArray;
    json["id"] = id;
    json["version"] = ++version;

    if (NULL != mapInfo())
    {
        QJsonObject mapObj;
        mapInfo()->write(mapObj);
        json["mapInfo"] = mapObj;
    }
}

void EAItem::writeAnswers(EAUser* user, QJsonObject &json)
{
    json[user->user()] = getAnsers();
}

QJsonArray EAItem::getAnsers()
{
    QJsonArray answersArray;
    foreach (EaQuestion* answer, m_eaQuestions)
    {
        QJsonObject answerObj;
        answer->writeAnswer(answerObj);
        answersArray.append(answerObj);
    }
    return answersArray;
}

int EAItem::itemType() const
{
    return m_itemType;
}

QString EAItem::title() const
{
    return m_title;
}

QString EAItem::data() const
{
    return m_data;
}

QString EAItem::displayText() const
{
    return m_displayText;
}

QUrl EAItem::url() const
{
    return m_url;
}

QString EAItem::urlString() const
{
    return m_url.url();
    //return m_urlString;
}

QQmlListProperty<EaQuestion> EAItem::questions()
{
    return QQmlListProperty<EaQuestion>(this
                                        , 0
                                        , &EAItem::append_eaQuestion
                                        , &EAItem::count_eaQuestion
                                        , &EAItem::at_eaQuestion
                                        , &EAItem::clear_eaQuestion
                                        );
}

void EAItem::addTextQuestion(const QString &questionText, int index)
{
    EaQuestion* newQuestion = new EaQuestion();
    newQuestion->setQuestionType(EaQuestion::QuestionType::Text);
    newQuestion->setQuestion(questionText);

    if ( index <0 || index > m_eaQuestions.count())
         m_eaQuestions.append(newQuestion);
    else
        m_eaQuestions.insert(index, newQuestion);
    emit eaQuestionsChanged();
}

void EAItem::deleteQuestion(int index)
{
    //m_eaQuestions
    if (index < m_eaQuestions.count() && index >= 0)
    {
        m_eaQuestions.removeAt(index);
        emit eaQuestionsChanged();
    }
    else
    {
        emit getEaItemList()->getEaContainer()->error(tr("Error")
                                                      ,tr("Error deleting question")
                    ,tr("Invalid index ") + QString::number(index)
                    ,"EAItemList::deleteItem"
                    , Warning);
    }
}

int EAItem::moveQuestion(int index, bool directionUp)
{
    if (index < m_eaQuestions.count() && index >= 0)
    {
        if (directionUp)
        {
            if (0 == index)
            {
                emit getEaItemList()->getEaContainer()->error(tr("Error")
                                                              ,tr("Error moving item")
                            ,tr("Item already at top of list")
                            ,"EAItemList::moveItem"
                            , Warning);
                return index;
            }
            else
            {
                m_eaQuestions.swap(index, index -1);
                emit eaQuestionsChanged();
                return index-1;
            }
        }
        else
        {
            if (m_eaQuestions.count()-1 == index)
            {
                emit getEaItemList()->getEaContainer()->error(tr("Error")
                                                              ,tr("Error moving itme")
                            ,tr("Item already at bottom of list")
                            ,"EAItemList::moveItem"
                            , Warning);
                return index;
            }
            else
            {
                m_eaQuestions.swap(index, index +1);
                emit eaQuestionsChanged();
                return index +1;
            }
        }
    }
    else
    {
        emit getEaItemList()->getEaContainer()->error(tr("Error")
                                                      ,tr("Error moving item")
                    ,tr("Invalid index ") + QString::number(index)
                    ,"EAItemList::moveItem"
                    , Warning);
        return -1;
    }
}
/*
void EAItem::saveAnswers()
{
    if (eaItemList
            && eaItemList->getEaContainer()
            && m_eaQuestions.length()>0)
    {
        eaItemList->getEaContainer()->saveAnswers(eaItemList, this, m_eaQuestions);
    }
}
*/
void EAItem::setItemType(int itemType)
{
    if (m_itemType == itemType)
        return;

    m_itemType = itemType;
    if (ItemType::Map == itemType)
        setMapInfo(new EAMap());
    emit itemTypeChanged(itemType);
}

void EAItem::setTitle(QString title)
{
    if (m_title == title)
        return;

    m_title = title;
    emit titleChanged(title);
}

void EAItem::setData(QString data)
{
    if (m_data == data)
        return;

    m_data = data;
    emit DataChanged(data);
}

void EAItem::setDisplayText(QString displayText)
{
    if (m_displayText == displayText)
        return;

    m_displayText = displayText;
    emit displayTextChanged(displayText);
}

void EAItem::setUrl(QUrl url)
{
    if (m_url == url)
        return;

    m_url = url;
    emit urlChanged(url);
}

void EAItem::setUrlString(QString urlString)
{
    if (m_urlString == urlString)
        return;

    m_urlString = urlString;
    emit urlStringChanged(urlString);
}

void EAItem::setMapInfo(EAMap *mapInfo)
{
    if (m_mapInfo == mapInfo)
        return;

    m_mapInfo = mapInfo;
    emit mapInfoChanged(mapInfo);
}

void EAItem::setShowPicture(bool showPicture)
{
    if (m_showPicture == showPicture)
        return;

    m_showPicture = showPicture;
    emit showPictureChanged(showPicture);
}


//typedef QQmlListProperty::AppendFunction
//Synonym for void (*)(QQmlListProperty<T> *property, T *value).
//Append the value to the list property.
void EAItem::append_eaQuestion(QQmlListProperty<EaQuestion> *list
                                     , EaQuestion *itemList)
{
    EAItem *eaItemColl = qobject_cast<EAItem *>(list->object);
    if (itemList) {
        //itemList->setParentItem(eaContainer); //???
        eaItemColl->m_eaQuestions.append(itemList);
    }
}

//typedef QQmlListProperty::CountFunction
//Synonym for int (*)(QQmlListProperty<T> *property).
//Return the number of elements in the list property.
int EAItem::count_eaQuestion(QQmlListProperty<EaQuestion> *list)
{
    EAItem *eaItemColl = qobject_cast<EAItem *>(list->object);
    return eaItemColl->m_eaQuestions.count();
}

//typedef QQmlListProperty::AtFunction
//Synonym for T *(*)(QQmlListProperty<T> *property, int index).
//Return the element at position index in the list property.
EaQuestion* EAItem::at_eaQuestion(QQmlListProperty<EaQuestion> *list
                                        , int index)
{
    EAItem *eaItemColl = qobject_cast<EAItem *>(list->object);
    return eaItemColl->m_eaQuestions[index];
}

//typedef QQmlListProperty::ClearFunction
//Synonym for void (*)(QQmlListProperty<T> *property).
//Clear the list property.
void EAItem::clear_eaQuestion(QQmlListProperty<EaQuestion> *list)
{
    EAItem *eaItemColl = qobject_cast<EAItem *>(list->object);
    eaItemColl->m_eaQuestions.clear();
}

QList<EaQuestion *> EAItem::getEaQuestions() const
{
    return m_eaQuestions;
}

void EAItem::setEaQuestions(const QList<EaQuestion *> &eaQuestions)
{
    m_eaQuestions = eaQuestions;
}

EAMap *EAItem::mapInfo() const
{
    return m_mapInfo;
}

bool EAItem::showPicture() const
{
    return m_showPicture;
}

EAItemList *EAItem::getEaItemList() const
{
    return eaItemList;
}

void EAItem::setEaItemList(EAItemList *value)
{
    eaItemList = value;
}





























