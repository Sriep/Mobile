#ifndef DECK_H
#define DECK_H
#include <vector>
#include "card.h"

using namespace std;



class BeziqueDeck
{
    const unsigned int beziqueDeckSize = 8*8;
    const unsigned int beziqueHandSize = 8;
public:
    BeziqueDeck(unsigned int size);
    BeziqueDeck();

    void shuffle();
    vector<Card> dealHand();
    Card peekBottom() const;
    Card dealTop();
    bool empty() const;
private:
    void stackDeck();
    vector<int> deck;
};

#endif // DECK_H
