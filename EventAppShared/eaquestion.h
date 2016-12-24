#ifndef EAQUESTION_H
#define EAQUESTION_H
#include <QJsonObject>
#include <QQuickItem>

class EaQuestion : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(int questionType READ questionType WRITE setQuestionType NOTIFY questionTypeChanged)
    Q_PROPERTY(QString question READ question WRITE setQuestion NOTIFY questionChanged)

    int m_questionType = 0;
    QString m_question;

public:
    enum QuestionType { Text=0 };
    Q_ENUM(QuestionType)

    EaQuestion();

    int questionType() const;
    QString question() const;

    void read(const QJsonObject &json);
    void write(QJsonObject &json);

signals:

    void questionTypeChanged(int questionType);
    void questionChanged(QString question);

public slots:
    void setQuestionType(int questionType);
    void setQuestion(QString question);
};

#endif // EAQUESTION_H
