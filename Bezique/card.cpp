#include "card.h"



Card::Card(int rank, int suit)
    : rank(rank), suit(suit)
{
}

Card::~Card()
{
}

bool Card::beats(const Card &c, int trumps)
{
    if ( suit == c.suit ) return rank > c.rank;
    if ( c.suit == trumps ) return false;
    return true;
}

Card::Card(const Card& c)
    : rank(c.rank), suit(c.suit)
{}

Card::Card()
    : rank(0), suit(0)
{
}

Card::Card(int iCard)
    : rank(intToCard(iCard).rank), suit(intToCard(iCard).suit)
{
}


Card Card::intToCard(int intCard)
{
    Card card;
    card.rank = intCard / 8;
    card.suit = intCard % 4;
    return card;
}
