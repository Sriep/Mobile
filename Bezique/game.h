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

class Game : public QStateMachine
{
    Q_OBJECT
public:
    Game(GameData* gameData, QStateMachine *parent = 0);
    virtual ~Game();

private slots:
    void cutForDeal();
    void dealCards();
    void playMainTrick();
    void playEndTrick();
    void endGame();
signals:
    void deckCut();
    void handsDealt();
    void trickFinished();
    void startEndgame();
    void handOver();
    void gameOver();
private:
    void init();
    void switchActivePlayer();

    BeziqueDeck deck;
    int startPlayer;
    std::shared_ptr<Player> player1;
    std::shared_ptr<Player> player2;
    std::shared_ptr<Player> activePlayer;
    int trumps;
    Card* faceCard;
    GameData* gameData;
};


#endif // GAME_H
