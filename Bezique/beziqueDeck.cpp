#include <cstdlib>


#include "beziqueDeck.h"

BeziqueDeck::BeziqueDeck()
{
}

void BeziqueDeck::shuffle()
{
    stackDeck();
    const unsigned int deckSize = deck.size();
    for ( unsigned int i = 0 ; i < deckSize - 1 ; i++ )
    {
        int rndIndex = rand() % (deckSize - i) + i ;
        int temp = deck[rndIndex];
        deck[rndIndex] = deck[i];
        deck[i] = temp;
    }
}

vector<Card> BeziqueDeck::dealHand()
{
    vector<Card> hand;
    for ( unsigned int i = 0 ; i < beziqueHandSize ; i++ )
    {
        hand.push_back(Card::intToCard(deck.back()));
        deck.pop_back();
    }
    return hand;
}



Card BeziqueDeck::peekBottom() const
{
    return Card::intToCard(deck.front());
}

Card BeziqueDeck::dealTop()
{
    Card card = Card::intToCard(deck.back());
    deck.pop_back();
    return card;
}

bool BeziqueDeck::empty() const
{
    return deck.empty();
}

void BeziqueDeck::stackDeck()
{
    deck.resize(beziqueDeckSize);
    for ( unsigned int i = 0 ; i < beziqueDeckSize ; i++ )
    {
        deck[i] = i;
    }
}





























