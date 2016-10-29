#ifndef GAME_H
#define GAME_H
#include <QStateMachine>
#include <memory>

//#include "card.h"
#include "beziqueDeck.h"

using namespace std;
class Player;
class Card;
class GameData;

class GameState : public QStateMachine
{
    Q_OBJECT
public:
    GameState(GameData* gameData, QStateMachine *parent = 0);
    virtual ~GameState();

private slots:
    //void cutForDeal();
    //void dealCards();
    //void playMainTrick();
    //void playEndTrick();
    void endGame();
public:
signals:

private:
    void init();
    void switchActivePlayer();

  //  BeziqueDeck deck;
   // int startPlayer;
   // std::shared_ptr<Player> player1;
    //std::shared_ptr<Player> player2;
   // std::shared_ptr<Player> activePlayer;
    //int trumps;
    //Card* faceCard;
    GameData* gameData;
};


#endif // GAME_H
