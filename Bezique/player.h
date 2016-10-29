#ifndef PLAYER_H
#define PLAYER_H
//#include <vector>
#include <QList>
#include <QQuickItem>
#include <QObject>
#include "beziqueDeck.h"
#include "beziquehand.h"
#include "game.h"

using namespace std;

class Player : public QQuickItem
{
    Q_OBJECT
    //Q_PROPERTY(int score READ getScore WRITE setScore)
public:
    static const int winningThreshold = 1000;

    Player(Game& game, QQuickItem *parent = 0);

    void dealtHand(QList<int> dealtHand);
    virtual Card* playFirstCard();
    virtual Card* playSecondCard();
    virtual Card* playFirstCardEndgame();
    virtual Card* playSecondCardEndgame();
    virtual void meld();
    void giveCard(int iCard);
    bool handEmpty() const;
    bool won() const;
    void incScore(int increment);

    int getScore() const;
    void setScore(int value);

private:
    //vector<Card> hand;
    BeziqueHand hand;
    Game& game;
    int score;
};

#endif // PLAYER_H
