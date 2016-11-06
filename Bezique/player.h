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
#include "unseencards.h"

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
    virtual void meldAuto(int trumps, bool seven);
    virtual void meldRecursive(int trumps, bool seven);
    void meldCard(int index, int trumps, bool seven);
    void giveCard(int iCard);
    bool handEmpty() const;
    bool won() const;
    void incScore(int increment);
    Card* playCard(int index, bool melded = false);
    bool canMeld();

    int getScore() const;
    void setScore(int value);

    //virtual bool isControlled() const = 0;

    BeziqueHand *getHand() const;
    void setHand(BeziqueHand *value);

    bool isAi() const;
    void setAi(bool value);
    UnseenCards getUnseen();

    Player *getOpponent() const;
    void setOpponent(Player *value);

    void setGameData(GameData *value);

signals:
    void scoreChanged();
protected:
    BeziqueHand* hand;
private:
    void init();
    int semiRandomCard() const;

    Player* opponent;
    UnseenCards unseen;
    GameData* gameData;
    int score = 0;
    bool ai;
};

#endif // PLAYER_H
