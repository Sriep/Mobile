#include <QDebug>
#include <limits>
#include <math.h>

#include "aievaluate.h"
#include "beziquehand.h"
#include "unseencards.h"
#include "gamedata.h"

AiEvaluate::AiEvaluate(BeziqueHand *hand
                       , QList<Card *> opponentMelds
                       , UnseenCards *unseen
                       , GameData* gameData)
    :   hand(hand)
        , opponentMelds(opponentMelds)
        , aiCards(hand->cardList())
        , unseen(unseen)
        , unseenCount(max(1, unseen->numUnseen()))
        , trumps((Card::Suit) gameData->getTrumps())
        , sevenPlayed(gameData->getMeldedSeven())
        , opponentLead(gameData->getHumansCard())
        , faceCard(gameData->getFaceCard())
        , deck(gameData->getDeck())
        , tricksLeft(deck->size() / 2)
{
    //deck = gameData->getDeck();
}

int AiEvaluate::operator()() const
{
    float lowestValue = std::numeric_limits<float>::max();
    int indexLowest = 0;
    for ( int i = 0 ; i < aiCards.length() ; i++ )
    {
        float value = evaluate(aiCards[i]);
        if (lowestValue < value)
        {
            indexLowest = i;
            lowestValue = value;
        }
    }
    return indexLowest;
}

float AiEvaluate::evaluate(Card *card) const
{
    float score = 0.0;
    switch (card->getRank()) {
        case Card::Rank::Seven:
            score += evaluateSeven(card);
            break;
        case Card::Rank::Eight:
            score += evaluateEight(card);
            break;
        //default:
    }
    score += costOfLead();
    qDebug() << card->getRank() << card->getSuit() << "Cost of card: " << score;
    return score;
}

float AiEvaluate::costOfLead() const
{
    float cost = 0.0;
    cost += 5 * (1+hand->countTensAces())/9;
    cost -= hand->scoreMelds(trumps) / ((unseenCount + 1)/2);
    return cost;
}

float AiEvaluate::probOfFlush() const
{
    float prob = 1.0;
    if (hand->count(Card::Rank::Jack, trumps) == 0)
        prob *= unseen->numUnseen(Card::Rank::Jack, trumps) * tricksLeft/unseenCount;
    if (hand->count(Card::Rank::Queen, trumps) == 0)
        prob *= unseen->numUnseen(Card::Rank::Queen, trumps) * tricksLeft/unseenCount;
    if (hand->count(Card::Rank::King, trumps) == 0)
        prob *= unseen->numUnseen(Card::Rank::King, trumps) * tricksLeft/unseenCount;
    if (hand->count(Card::Rank::Ten, trumps) == 0)
        prob *= unseen->numUnseen(Card::Rank::Ten, trumps) * tricksLeft/ unseenCount;
    if (hand->count(Card::Rank::Ace, trumps) == 0)
        prob *= unseen->numUnseen(Card::Rank::Ace, trumps) * tricksLeft/unseenCount;
    return prob;
}

float AiEvaluate::probOfBezique() const
{
    float prob = 1.0;
    if (hand->count(Card::Rank::Jack, Card::Suit::Diamonds) == 0)
        prob *= unseen->numUnseen(Card::Rank::Jack, Card::Suit::Diamonds)
                * tricksLeft/unseenCount;
    if (hand->count(Card::Rank::Queen, Card::Suit::Spades) == 0)
        prob *= unseen->numUnseen(Card::Rank::Queen, Card::Suit::Spades)
                * tricksLeft/unseenCount;
    return prob;
}

float AiEvaluate::probOfDoubleBezique() const
{
    float prob = 1.0;
    if (hand->count(Card::Rank::Jack, Card::Suit::Diamonds) == 1)
    {
        prob *= unseen->numUnseen(Card::Rank::Jack, Card::Suit::Diamonds)
                * tricksLeft/unseenCount;
    }
    else  if (hand->count(Card::Rank::Jack, Card::Suit::Diamonds) == 0)
    {
        if (unseen->numUnseen(Card::Rank::Jack, Card::Suit::Diamonds) > 1
                && tricksLeft > 1 && unseenCount > 1)
            prob *= unseen->numUnseen(Card::Rank::Jack, Card::Suit::Diamonds)
                    * tricksLeft/unseenCount
                    * (unseen->numUnseen(Card::Rank::Jack, Card::Suit::Diamonds)-1)
                    * (tricksLeft-1)/(unseenCount-1);
        else
            prob = 0;
    }

    if (hand->count(Card::Rank::Queen, Card::Suit::Spades) == 1)
    {
        prob *= unseen->numUnseen(Card::Rank::Queen, Card::Suit::Spades)
                * tricksLeft/unseenCount;
    }
    else  if (hand->count(Card::Rank::Queen, Card::Suit::Spades) == 0)
    {
        if (unseen->numUnseen(Card::Rank::Queen, Card::Suit::Spades) > 1
                && tricksLeft > 1 && unseenCount > 1)
            prob *= unseen->numUnseen(Card::Rank::Queen, Card::Suit::Spades)
                    * tricksLeft/unseenCount
                    * (unseen->numUnseen(Card::Rank::Queen, Card::Suit::Spades)-1)
                    * (tricksLeft-1)/(unseenCount-1);
        else
            prob = 0;
    }

    return prob;
}

float AiEvaluate::probOfMarrage(Card::Suit suit) const
{
    float prob =1.0;
    if (hand->count(Card::Rank::King, suit) == 0)
        prob *= unseen->numUnseen(Card::Rank::King, suit)
                * tricksLeft/unseenCount;
    if (hand->count(Card::Rank::Queen, suit) == 0)
        prob *= unseen->numUnseen(Card::Rank::Queen, suit)
                * tricksLeft/unseenCount;
    return prob;
}

float AiEvaluate::probOfFourKind(Card::Rank rank) const
{
    float prob = 1.0;
    if (hand->countRank(rank) == 3)
    {
        if (unseen->numUnseenRank(rank)!=0)
            prob *= unseen->numUnseenRank(rank) * tricksLeft/unseenCount;
        else prob = 0;
    }
    else if (hand->countRank(rank) == 2)
    {
        if (unseen->numUnseenRank(rank) > 1 && tricksLeft > 1 && unseenCount > 1)
            prob *= unseen->numUnseenRank(rank) * tricksLeft/unseenCount
                   * (unseen->numUnseenRank(rank)-1) * (tricksLeft-1)/(unseenCount-1);
        else
            prob = 0;
    }
    else if (hand->countRank(rank) == 1)
    {
        if (unseen->numUnseenRank(rank) > 2 && tricksLeft > 2 && unseenCount > 2)
            prob *= unseen->numUnseenRank(rank) * tricksLeft/unseenCount
                   * (unseen->numUnseenRank(rank)-1) * (tricksLeft-1)/(unseenCount-1)
                   * (unseen->numUnseenRank(rank)-2) * (tricksLeft-2)/(unseenCount-2);
        else
            prob = 0;
    }
    else if (hand->countRank(rank) == 0)
    {
        if (unseen->numUnseenRank(rank) > 3 && tricksLeft > 3 && unseenCount > 3)
            prob *= unseen->numUnseenRank(rank) * tricksLeft/unseenCount
                   * (unseen->numUnseenRank(rank)-1) * (tricksLeft-1)/(unseenCount-1)
                   * (unseen->numUnseenRank(rank)-2) * (tricksLeft-2)/(unseenCount-2)
                   * (unseen->numUnseenRank(rank)-3) * (tricksLeft-3)/(unseenCount-3);
        else
            prob = 0;
    }
    return prob;
}



float AiEvaluate::evaluateSeven(Card* card) const
{
    float value = 0.0;
    if (1 == hand->count(Card::Seven, trumps))
    {
        value += evaluate(faceCard)/2;
    }
    return value;
}

float AiEvaluate::evaluateEight(Card *card) const
{
    return 0.0;
}

float AiEvaluate::evaluateNine(Card *card) const
{
    return 0.0;
}

float AiEvaluate::evaluateTen(Card *card) const
{
    float value = 0.0;
    if (hand->count(Card::Rank::Ten, trumps) < 2)
    {
        value += SCORE_FLUSH * probOfFlush();
        value -= SCORE_FLUSH * unseen->numUnseen(card->getRank(), trumps)
                             * tricksLeft/unseenCount;
    }

    if (opponentLead)
    {
        if (opponentLead->beats(*card, card->getSuit()))
            value += COST_LOOSING_TEN;
        else
            value -= 10 - COST_LOOSING_TEN;
    }
    else
    {
        bool beatsOurTen = false;
        for ( int i=0 ; i < opponentMelds.length() ; i++ )
        {
            if ( !card->beats(*opponentMelds[i], trumps) )
                beatsOurTen = true;
        }
        if (beatsOurTen)
            value += COST_LOOSING_TEN;
        else
            value += COST_LOOSING_TEN * unseen->unseenThatBeat(card, trumps)
                    * (BeziqueHand::HAND_SIZE - opponentMelds.size())
                    / unseenCount;
    }
    return value;
}

float AiEvaluate::evaluateJack(Card *card) const
{
    float value = 0.0;
    if (hand->count(Card::Rank::Jack, trumps) < 2)
    {
        value += SCORE_FLUSH * probOfFlush();
        value -= SCORE_FLUSH * unseen->numUnseen(card->getRank(), trumps)
                             * tricksLeft/unseenCount;
    }

    if (hand->countRank(Card::Rank::Jack) < 5)
    {
        value += SCORE_FOUR_JACKS * probOfFourKind(Card::Rank::Jack);
        value -= SCORE_FOUR_JACKS * unseen->numUnseenRank(Card::Rank::Jack)
                                  * tricksLeft/unseenCount;
    }

    if(card->getSuit() == Card::Suit::Diamonds)
    {
        if (hand->count(Card::Rank::Jack, Card::Suit::Diamonds) == 1)
        {
            value += SCORE_BEZIQUE * probOfBezique();
            value -= SCORE_FOUR_JACKS * unseen->numUnseenRank(Card::Rank::Jack)
                                      * tricksLeft/unseenCount;
        }
        if (hand->count(Card::Rank::Jack, Card::Suit::Diamonds) == 2)
        {
            value += SCORE_DOUBLE_BEZIQUE * probOfDoubleBezique();
        }
    }

    return value;
}

float AiEvaluate::evaluateQueen(Card *card) const
{
    float value = 0.0;

    if (hand->count(Card::Rank::Queen, trumps) < 2)
    {
        value += SCORE_FLUSH * probOfFlush();
        value -= SCORE_FLUSH * unseen->numUnseen(card->getRank(), trumps)
                             * tricksLeft/unseenCount;
    }

    if (hand->countRank(Card::Rank::Queen) < 5)
    {
        value += SCORE_FOUR_JACKS * probOfFourKind(Card::Rank::Queen);
        value -= SCORE_FOUR_JACKS * unseen->numUnseenRank(Card::Rank::Queen)
                                  * tricksLeft/unseenCount;
    }

    if(card->getSuit() == Card::Suit::Diamonds)
    {
        if (hand->count(Card::Rank::Queen, Card::Suit::Spades) == 1)
        {
            value += SCORE_BEZIQUE * probOfBezique();
            value -= SCORE_FOUR_JACKS
                    * unseen->numUnseen(Card::Rank::Queen, Card::Suit::Spades)
                    * tricksLeft/unseenCount;
        }
        if (hand->count(Card::Rank::Queen, Card::Suit::Spades) == 2)
        {
            value += SCORE_DOUBLE_BEZIQUE * probOfDoubleBezique();
        }
    }

    if (hand->count(Card::Rank::Queen, (Card::Suit) card->getSuit()) == 1)
    {
        int score = card->getSuit() == trumps ? SCORE_ROYAL_MARRAGE : SCORE_MARRAGE;
        value += score * probOfBezique();
        value -= score * unseen->numUnseen(Card::Rank::Queen, card->getSuit())
                                  * tricksLeft/unseenCount;
    }

    return value;
}

float AiEvaluate::evaluateKing(Card *card) const
{
    float value = 0.0;

    if (hand->count(Card::Rank::King, trumps) < 2)
    {
        value += SCORE_FLUSH * probOfFlush();
        value -= SCORE_FLUSH * unseen->numUnseen(card->getRank(), trumps)
                             * tricksLeft/unseenCount;
    }

    if (hand->countRank(Card::Rank::King) < 5)
    {
        value += SCORE_FOUR_JACKS * probOfFourKind(Card::Rank::King);
        value -= SCORE_FOUR_JACKS * unseen->numUnseenRank(Card::Rank::King)
                                  * tricksLeft/unseenCount;
    }

    if (hand->count(Card::Rank::King, (Card::Suit) card->getSuit()) == 1)
    {
        int score = card->getSuit() == trumps ? SCORE_ROYAL_MARRAGE : SCORE_MARRAGE;
        value += score * probOfBezique();
        value -= score * unseen->numUnseen(Card::Rank::King, card->getSuit())
                                  * tricksLeft/unseenCount;
    }

    return value;
}

float AiEvaluate::evaluateAce(Card *card) const
{
    float value = 0.0;

    if (hand->count(Card::Rank::Ace, trumps) < 2)
    {
        value += SCORE_FLUSH * probOfFlush();
        value -= SCORE_FLUSH * unseen->numUnseen(card->getRank(), trumps)
                             * tricksLeft/unseenCount;
    }

    if (hand->countRank(Card::Rank::Ace) < 5)
    {
        value += SCORE_FOUR_JACKS * probOfFourKind(Card::Rank::Ace);
        value -= SCORE_FOUR_JACKS * unseen->numUnseenRank(Card::Rank::Ace)
                                  * tricksLeft/unseenCount;
    }

    if (opponentLead)
    {
        if (opponentLead->beats(*card, card->getSuit()))
            value += COST_LOOSING_ACE;
        else
            value -= 10 - COST_LOOSING_ACE;
    }
    else
    {
        bool beatsOurTen = false;
        for ( int i=0 ; i < opponentMelds.length() ; i++ )
        {
            if ( !card->beats(*opponentMelds[i], trumps) )
                beatsOurTen = true;
        }
        if (beatsOurTen)
            value += COST_LOOSING_ACE;
        else
            value += COST_LOOSING_ACE * unseen->unseenThatBeat(card, trumps)
                    * (BeziqueHand::HAND_SIZE - opponentMelds.size())
                    / unseenCount;
    }
    return value;
}
































































