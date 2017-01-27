#ifndef EAQUESTION_H
#define EAQUESTION_H
#include <QJsonObject>
#include <QQuickItem>

class EAItem;
class EaQuestion : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(int questionType READ questionType WRITE setQuestionType NOTIFY questionTypeChanged)
    Q_PROPERTY(QString question READ question WRITE setQuestion NOTIFY questionChanged)
    Q_PROPERTY(QString answer READ answer WRITE setAnswer NOTIFY answerChanged)

    int m_questionType = 0;
    QString m_question;    
    QString m_answer;

public:
    enum QuestionType { Text=0 };
    Q_ENUM(QuestionType)

    EaQuestion();

    int questionType() const;
    QString question() const;
    QString answer() const;

    void read(const QJsonObject &json, EAItem* parent);
    void write(QJsonObject &json);    
    //void readAnswer(const QJsonObject &json);
    void writeAnswer(QJsonObject &json);


    EAItem *getParentItem() const;
    void setParentItem(EAItem *value);

signals:

    void questionTypeChanged(int questionType);
    void questionChanged(QString question);
    void eaAnswersDownloaded();
    void answerChanged(QString answer);

public slots:
    void setQuestionType(int questionType);
    void setQuestion(QString question);
    void setAnswer(QString answer);
    void onAnswersReady(QByteArray data);

private:
    EAItem* parentItem;
};

#endif // EAQUESTION_H
