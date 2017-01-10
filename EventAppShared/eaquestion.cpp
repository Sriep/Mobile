#include <QJsonObject>
#include <QJsonArray>
#include "eaquestion.h"
#include "eaitem.h"
#include "eauser.h"
#include "eaitemlist.h"
#include "eacontainer.h"
#include "firebase.h"

EaQuestion::EaQuestion()
{

}

int EaQuestion::questionType() const
{
    return m_questionType;
}

QString EaQuestion::question() const
{
    return m_question;
}

void EaQuestion::read(const QJsonObject &json, EAItem* parent)
{
    setParentItem(parent);
    setQuestionType(json["type"].toInt());
    setQuestion(json["question"].toString());

    EAContainer* container = parent->getEaItemList()->getEaContainer();
    if (container->user()->user().size() > 0)
    {
        QString path = container->eventKey();
        path += "/answers";
        path += "/" + parent->getEaItemList()->listName();
        path += "/" + parent->title();
        path += "/" + container->user()->user();

        Firebase *firebase=new Firebase(container->firbaseUrl(), path);
        firebase->getValue();
        connect(firebase,SIGNAL(eventAnswersReady(QByteArray)),
                this,SLOT(onAnswersReady(QByteArray)));
        //connect(firebase,SIGNAL(eventAnswersChanged(QString)),
        //        this,SLOT(onDataChanged(QString*)));
    }
}

void EaQuestion::onAnswersReady(QByteArray data)
{
    qDebug()<<"answer";
    QJsonDocument loadDoc = QJsonDocument::fromJson(data);
    QJsonObject answersObj = loadDoc.object();
    qDebug() << "EAContainer::onAnswersReady finished";
    emit eaAnswersDownloaded();
}

void EaQuestion::write(QJsonObject &json)
{
    json["type"] = questionType();
    json["question"] = question();
}

void EaQuestion::writeAnswer(QJsonObject &json)
{
    write(json);
    json["answer"] = answer();
}

QString EaQuestion::answer() const
{
    return m_answer;
}

void EaQuestion::setQuestionType(int questionType)
{
    if (m_questionType == questionType)
        return;

    m_questionType = questionType;
    emit questionTypeChanged(questionType);
}

void EaQuestion::setQuestion(QString question)
{
    if (m_question == question)
        return;

    m_question = question;
    emit questionChanged(question);
}

void EaQuestion::setAnswer(QString answer)
{
    if (m_answer == answer)
        return;

    m_answer = answer;
    emit answerChanged(answer);
}

EAItem *EaQuestion::getParentItem() const
{
    return parentItem;
}

void EaQuestion::setParentItem(EAItem *value)
{
    parentItem = value;
}
