#ifndef AIENDPLAY_H
#define AIENDPLAY_H
#include <QList>

#include "card.h"
static const int NOT_FOUND = -1;
//static void rankSortAppend(QList<Card*>& list, Card*card);
//static int findRank(QList<Card*>& list, Card::Rank rank);

class AiEndPlay
{
public:
    AiEndPlay(QList<Card*> ai
              , QList<Card*> opp
              , Card::Suit trumps
              , Card* lead);
    int operator()();

private:
    void init();
    Card* followCard();
    Card* leadCard(QList<Card*> hand);
    QList<Card*> legalFollow(QList<Card*> hand, Card* lead);
    Card* candropSingeltonAceTen();
    Card* canDropTen();
    Card* canleadIntoVoid();
    Card* leadSuitPositiveDelta();
    Card* leadTrumps();
    int findIndex(Card* card);

    //bool finiessableTen(Card::Suit suit);


    QList<Card*> ai;
    QList<Card*> opp;
    Card::Suit trumps;
    Card* lead;

    bool winTrick = false;
    QList<Card*> aiSuits [Card::Suit::NumSuits];
    QList<Card*> oppSuits [Card::Suit::NumSuits];
};

inline static void rankSortAppend(QList<Card*> &list, Card *card)
{
    if (list.length() == 0)
    {
        list.append(card);
        return;
    }
    for ( int i=0 ; i< list.length() ; i++)
    {
        if (card->getRank() > list[i]->getRank())
        {
            list.insert(i,card);
            return;
        }
    }
    list.append(card);
}

inline static int findRank(QList<Card *> &list, Card::Rank rank)
{
    for ( int i=0 ; i < list.length() ; i++ )
    {
        if (list[i]->getRank() == rank)
            return i;
    }
    return NOT_FOUND;
}

#endif // AIENDPLAY_H
