#include <QJsonObject>
#include <QJsonArray>
#include "eaquestion.h"

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

void EaQuestion::read(const QJsonObject &json)
{
    setQuestionType(json["type"].toInt());
    setQuestion(json["question"].toString());
}

void EaQuestion::write(QJsonObject &json)
{
    json["type"] = questionType();
    json["question"] = question();
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
