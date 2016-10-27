#ifndef PLAYER_H
#define PLAYER_H
#include <vector>
#include "beziqueDeck.h"
#include "game.h"

using namespace std;

class Player
{
public:
    static const int winningThreshold = 1000;
    Player(Game& game);
    void dealtHand(vector<Card> dealtHand);
    virtual Card playFirstCard();
    virtual Card playSecondCard();
    virtual Card playFirstCardEndgame();
    virtual Card playSecondCardEndgame();
    virtual void meld();
    void giveCard(const Card& card);
    bool handEmpty() const;
    bool won() const;
    void incScore(int increment);

private:
    vector<Card> hand;
    Game& game;
    int score;
};

#endif // PLAYER_H
