#ifndef AIEVALUATE_H
#define AIEVALUATE_H
#include <QList>
#include "card.h"

class BeziqueHand;
class UnseenCards;
class GameData;
class BeziqueDeck;

class AiEvaluate
{
public:
    AiEvaluate(BeziqueHand* hand
               , QList<Card*> opponentMelds
               , UnseenCards* unseen
               , GameData* gameData);

    int operator()() const;

public:
    static const int COST_LOOSING_TEN = 6;
    static const int COST_LOOSING_ACE = 10;

private:
    float evaluate(Card* card) const;
    float evaluateSeven(Card *card) const;
    float evaluateEight(Card *card) const;
    float evaluateNine(Card *card) const;
    float evaluateTen(Card *card) const;
    float evaluateJack(Card *card) const;
    float evaluateQueen(Card *card) const;
    float evaluateKing(Card *card) const;
    float evaluateAce(Card *card) const;

    float costOfLead() const;
    float probOfFlush() const;
    float probOfFourKind(Card::Rank rank) const;
    float probOfBezique() const;
    float probOfDoubleBezique() const;
    float probOfMarrage(Card::Suit suit) const;


    BeziqueHand* hand;
    QList<Card*> opponentMelds;
    QList<Card*> aiCards;
    UnseenCards* unseen;
    int unseenCount;
    Card::Suit trumps;
    bool sevenPlayed;
    Card* opponentLead;
    Card* faceCard;
    BeziqueDeck* deck;
    int tricksLeft;
};

#endif // AIEVALUATE_H
