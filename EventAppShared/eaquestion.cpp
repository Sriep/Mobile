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
