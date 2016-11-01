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
    Q_PROPERTY(QQmlListProperty<Card> meldedCards READ getMeldedCards)
    Q_PROPERTY(QQmlListProperty<Card> hiddedCards READ getHiddenCards)
public:
    friend class Player;
    static const int HAND_SIZE = 8;

    BeziqueHand(QQuickItem *parent = 0);
    virtual ~BeziqueHand();

    void resetCards(QList<int> newHand);
    bool isEmpty() const;
    void addCard(int cardId);
    const Card *peek(int index);
    Card *playCard(int index, bool melded = false);
    int findLink(int index, bool melded = false);

    QQmlListProperty<Card> getCards();
    QQmlListProperty<Card> getMeldedCards();
    QQmlListProperty<Card> getHiddenCards();

signals:
    void enginPlayedCard(int index);
public slots:
private:
    static void appendCard(QQmlListProperty<Card> *list, Card *card);
    static void appendMeldedCard(QQmlListProperty<Card> *list, Card *card);
    static void appendHiddenCard(QQmlListProperty<Card> *list, Card *card);
    QList<Card*> cards;
    QList<Card*> meldedCards;
    QList<Card*> hiddedCards;
};

#endif // BEZIQUEHAND_H
