#ifndef PLAYER_H
#define PLAYER_H
//#include <vector>
#include <QList>
#include <QQuickItem>
#include <QObject>
#include "beziqueDeck.h"
#include "beziquehand.h"
#include "gamestate.h"
#include "card.h"

using namespace std;

class Player : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(BeziqueHand* hand READ getHand WRITE setHand)
    Q_PROPERTY(bool ai READ isAi WRITE setAi)
    Q_PROPERTY(int score READ getScore WRITE setScore NOTIFY scoreChanged)
public:
    static const int winningThreshold = 1000;

    Player(QQuickItem *parent = 0);
    //Player();

    void dealtHand(QList<int> dealtHand);
    virtual Card *playFirstCard();
    virtual Card *playSecondCard();
    virtual Card* playFirstCardEndgame();
    virtual Card *playSecondCardEndgame();
    virtual void meld();
    void giveCard(int iCard);
    bool handEmpty() const;
    bool won() const;
    void incScore(int increment);
    Card* playCard(int index, bool melded = false);

    int getScore() const;
    void setScore(int value);

    //virtual bool isControlled() const = 0;

    BeziqueHand *getHand() const;
    void setHand(BeziqueHand *value);

    bool isAi() const;
    void setAi(bool value);
signals:
    void scoreChanged();
    //void enginPlayedCard(const Card* playedCard);
    //void enginPlayedCard(int index);
protected:
    BeziqueHand* hand;
private:
    void init();

    int score = 0;
    bool ai;
};

#endif // PLAYER_H
