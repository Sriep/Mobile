#include "gamedata.h"
#include "gamestate.h"
#include "aiplayer.h"

GameData::GameData(QQuickItem *parent)
    : QQuickItem(parent)
    , game(this)

{
    player1 = new AiPlayer();
    player2 = new AiPlayer();
}

Card *GameData::getFaceCard() const
{
    return faceCard;
}

void GameData::setFaceCard(Card *value)
{
    faceCard = value;
}

void GameData::startNewGame()
{
    game.start();
}

void GameData::cardPlayed(int index)
{
    if (isPlayFirstCard)
    {
        firstCard = activePlayer->playCard(index);
        switchActivePlayer();
        emit leadCardPlayed();
    }
    else
    {
        secondCard = activePlayer->playCard(index);
        emit followedToTrick();
    }
}

void GameData::cutForDeal()
{
    activePlayer = rand() % 2 ? player1 : player2;
    emit deckCut();
}

void GameData::dealCards()
{
    deck.shuffle();
    player1->dealtHand(deck.dealHand());
    player2->dealtHand(deck.dealHand());
    faceCard = new Card(deck.peekBottom());
    trumps = faceCard->getSuit();
    emit handsDealt();
}

void GameData::leadToTrick()
{
    if (activePlayer->isControlled())
    {
        isPlayFirstCard = true;
        emit waitingForCard();
    }
    else
    {
        firstCard = activePlayer->playFirstCard();
        switchActivePlayer();
        emit leadCardPlayed();
    }
}

void GameData::followToTrick()
{
    if (activePlayer->isControlled())
    {
        isPlayFirstCard = false;
        emit waitingForCard();
    }
    else
    {
        secondCard = activePlayer->playFirstCard();
        switchActivePlayer();
        emit followedToTrick();
    }
}

void GameData::meld()
{
    activePlayer = firstCard->beats(*secondCard, trumps) ? player1 : player2;
    if (Card::Ace == firstCard->getRank() || Card::Ten == firstCard->getRank())
        activePlayer->incScore(10);
    if (Card::Ace == secondCard->getRank() || Card::Ten == secondCard->getRank())
        activePlayer->incScore(10);
    if (activePlayer->isControlled())
    {
        emit waitingForMeld();
    }
    else
    {
        activePlayer->meld();
    }
    player1->giveCard(deck.dealTop());
    player2->giveCard(deck.dealTop());
    if (activePlayer->won())
        emit gameOver();
    else if (deck.empty())
        emit startEndgame();
    else
        emit melded();
}

void GameData::switchActivePlayer()
{
    activePlayer = activePlayer == player1 ? player2 : player1;
}

void GameData::playEndTrick()
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















