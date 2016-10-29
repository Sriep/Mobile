#ifndef BEZIQUEHAND_H
#define BEZIQUEHAND_H
#include <QList>
#include <QQuickItem>

#include "card.h"

//using namespace std;

class BeziqueHand : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(int score READ getScore WRITE setScore NOTIFY scoreChanged)
    Q_PROPERTY(QQmlListProperty<Card> cards READ getCards)
public:
    BeziqueHand(QQuickItem *parent = 0);

    void resetCards(QList<int> newHand);
    bool isEmpty() const;
    void addCard(int cardId);
    Card *peek(int index);
    Card *playCard(int index);

    int getScore() const;
    void setScore(int value);
    void incScore(int amount);
    QQmlListProperty<Card> getCards();
    Q_INVOKABLE void selectCard(int x, int y);

    //setCards(QQmlListProperty<Card> cards);

    virtual ~BeziqueHand();
signals:
    void scoreChanged();
public slots:
private:
    static void appendCard(QQmlListProperty<Card> *list, Card *card);
    QList<Card*> cards;
    int playerScore;
};

#endif // BEZIQUEHAND_H
