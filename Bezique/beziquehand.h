#ifndef BEZIQUEHAND_H
#define BEZIQUEHAND_H
#include <QList>
#include <QQuickItem>

#include "card.h"

//using namespace std;

class BeziqueHand : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<Card> cards READ getCards)
public:
    friend class Player;
   // BeziqueHand(bool isHidden = true, QQuickItem *parent = 0);
    BeziqueHand(QQuickItem *parent = 0);
    virtual ~BeziqueHand();

    void resetCards(QList<int> newHand);
    bool isEmpty() const;
    void addCard(int cardId, int index);
    const Card *peek(int index);
    Card *playCard(int index);

    //int getScore() const;
    //void setScore(int value);
    //void incScore(int amount);
    QQmlListProperty<Card> getCards();
    //Q_INVOKABLE void selectCard(int x, int y);
    //setCards(QQmlListProperty<Card> cards);

    //bool getIsHidden() const;
    //void setIsHidden(bool value);

signals:
    void enginPlayedCard(int index);
public slots:
private:
    static void appendCard(QQmlListProperty<Card> *list, Card *card);
    QList<Card*> cards;
    //bool isHidden = true;
    int playerScore;
};

#endif // BEZIQUEHAND_H
