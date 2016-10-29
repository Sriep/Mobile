#include <QState>
#include <QFinalState>
#include <cstdlib>
#include "game.h"
#include "controledplayer.h"
#include "aiplayer.h"
#include "card.h"
#include "gamedata.h"

Game::Game(GameData* gameData, QStateMachine *parent)
    : QStateMachine(parent), gameData(gameData)
{
    player1.reset( new Player(*this));
    player2.reset( new Player(*this));
    init();
}

Game::~Game()
{
}

void Game::init()
{
    QState *cutForDeal = new QState();
    QState *dealCards = new QState();

    QState *leadToTrick = new QState();
    QState *followToTrick = new QState();
    QState *meld = new QState();
    QState *mainGameTrick = new QState();

    QState *endGameTrick = new QState();
    QFinalState *cleanUp = new QFinalState();

    QObject::connect(cutForDeal, SIGNAL(entered()), this, SLOT(cutForDeal()));
    cutForDeal->addTransition(this, SIGNAL(deckCut()), dealCards);

    QObject::connect(dealCards, SIGNAL(entered()), this, SLOT(dealCards()));
    dealCards->addTransition(this, SIGNAL(handsDealt()), mainGameTrick);

    QObject::connect(mainGameTrick, SIGNAL(entered()), this, SLOT(playMainTrick()));
    mainGameTrick->addTransition(this, SIGNAL(trickFinished()), mainGameTrick);
    mainGameTrick->addTransition(this, SIGNAL(startEndgame()), endGameTrick);
    mainGameTrick->addTransition(this, SIGNAL(gameOver()), cleanUp);

    QObject::connect(endGameTrick, SIGNAL(entered()), this, SLOT(playEndTrick()));
    endGameTrick->addTransition(this, SIGNAL(trickFinished()), endGameTrick);
    endGameTrick->addTransition(this, SIGNAL(handOver()), dealCards);
    endGameTrick->addTransition(this, SIGNAL(gameOver()), cleanUp);

    QObject::connect(cleanUp, SIGNAL(entered()), this, SLOT(endGame()));

    this->addState(cutForDeal);
    this->addState(dealCards);
    this->addState(mainGameTrick);
    this->addState(endGameTrick);
    this->addState(cleanUp);

    this->setInitialState(cutForDeal);
}

void Game::switchActivePlayer()
{
    activePlayer = activePlayer == player1 ? player2 : player1;
}

void Game::cutForDeal()
{
    activePlayer = rand() % 2 ? player1 : player2;
    emit deckCut();
}

void Game::dealCards()
{
    deck.shuffle();
    player1->dealtHand(deck.dealHand());
    player2->dealtHand(deck.dealHand());
    faceCard = new Card(deck.peekBottom());
    trumps = faceCard->getSuit();
    emit handsDealt();
}

void Game::playMainTrick()
{
    Card* firstCard = activePlayer->playFirstCard();
    switchActivePlayer();
    Card* secondCard = activePlayer->playSecondCard();

    activePlayer = firstCard->beats(*secondCard, trumps) ? player1 : player2;
    if (Card::Ace == firstCard->getRank() || Card::Ten == firstCard->getRank())
        activePlayer->incScore(10);
    if (Card::Ace == secondCard->getRank() || Card::Ten == secondCard->getRank())
        activePlayer->incScore(10);

    activePlayer->meld();
    if (activePlayer->won())
        emit gameOver();
    player1->giveCard(deck.dealTop());
    player2->giveCard(deck.dealTop());
    if (deck.empty())
        emit startEndgame();
    else
        emit trickFinished();
}

void Game::playEndTrick()
{
    Card* firstCard = activePlayer->playFirstCardEndgame();
    switchActivePlayer();
    Card* secondCard = activePlayer->playSecondCardEndgame();

    activePlayer = firstCard->beats(*secondCard, trumps) ? player1 : player2;
    if (Card::Ace == firstCard->getRank() || Card::Ten == firstCard->getRank())
        activePlayer->incScore(10);
    if (Card::Ace == secondCard->getRank() || Card::Ten == secondCard->getRank())
        activePlayer->incScore(10);

    if (activePlayer->won())
        emit gameOver();
    if (player1->handEmpty())
    {
        activePlayer->incScore(10);
        if (activePlayer->won())
            emit gameOver();
        else
            emit handOver();
    }
    else
        emit trickFinished();
}

void Game::endGame()
{

}




























