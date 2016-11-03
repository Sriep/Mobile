#include <QState>
#include <QFinalState>
#include <cstdlib>
#include "gamestate.h"
#include "controledplayer.h"
#include "aiplayer.h"
#include "card.h"
#include "gamedata.h"

GameState::GameState(GameData* gameData, QStateMachine *parent)
    : QStateMachine(parent), gameData(gameData)
{
   // player1.reset( new Player(*this));
    //player2.reset( new Player(*this));
    init();
}

GameState::~GameState()
{
}

void GameState::init()
{
    QState *cutForDeal = new QState();
    QState *dealCards = new QState();

    QState *leadToTrick = new QState();
    QState *followToTrick = new QState();
    QState *meld = new QState();
    //QState *mainGameTrick = new QState();

    QState *endGameTrick = new QState();
    QFinalState *cleanUp = new QFinalState();

    QObject::connect(cutForDeal, SIGNAL(entered()), this->gameData, SLOT(cutForDeal()));
    cutForDeal->addTransition(this->gameData, SIGNAL(deckCut()), dealCards);

    QObject::connect(dealCards, SIGNAL(entered()), this->gameData, SLOT(dealCards()));
    //dealCards->addTransition(this, SIGNAL(handsDealt()), mainGameTrick);
    dealCards->addTransition(this->gameData, SIGNAL(handsDealt()), leadToTrick);

    leadToTrick->addTransition(this->gameData, SIGNAL(leadCardPlayed()), followToTrick);
    followToTrick->addTransition(this->gameData, SIGNAL(followedToTrick()), meld);
    meld->addTransition(this->gameData, SIGNAL(melded()), leadToTrick);
    meld->addTransition(this->gameData, SIGNAL(startEndgame()), endGameTrick);
    meld->addTransition(this->gameData, SIGNAL(gameOver()), cleanUp);

    QObject::connect(leadToTrick, SIGNAL(entered()), this->gameData, SLOT(leadToTrick()));
    QObject::connect(followToTrick, SIGNAL(entered()), this->gameData, SLOT(followToTrick()));
    QObject::connect(meld, SIGNAL(entered()), this->gameData, SLOT(meld()));

    QObject::connect(endGameTrick, SIGNAL(entered()), this->gameData, SLOT(playEndTrick()));
    endGameTrick->addTransition(this->gameData, SIGNAL(trickFinished()), endGameTrick);
    endGameTrick->addTransition(this->gameData, SIGNAL(handOver()), dealCards);
    endGameTrick->addTransition(this->gameData, SIGNAL(gameOver()), cleanUp);

    QObject::connect(cleanUp, SIGNAL(entered()), this, SLOT(endGame()));

    this->addState(cutForDeal);
    this->addState(dealCards);

    this->addState(leadToTrick);
    this->addState(followToTrick);
    this->addState(meld);
    //this->addState(mainGameTrick);

    this->addState(endGameTrick);
    this->addState(cleanUp);

    this->setInitialState(cutForDeal);
}

void GameState::endGame()
{

}




























