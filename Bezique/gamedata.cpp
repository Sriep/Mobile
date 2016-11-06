#include <QThread>
#include <QDebug>

#include "player.h"
#include "gamedata.h"
#include "gamestate.h"
#include "unseencards.h"

GameData::GameData(QQuickItem *parent)
    : QQuickItem(parent)
    , game(this)

{
    init();
}

void GameData::init()
{
    game.start();
}

Card* GameData::getHumansCard() const
{
    return humansCard;
}

void GameData::setHumansCard(Card* value)
{
    humansCard = value;
}

Card* GameData::getAisCard() const
{
    return aisCard;
}

void GameData::setAisCard(Card* value)
{
    aisCard = value;
}

Player *GameData::getAiPlayer() const
{
    return aiPlayer;
}

void GameData::setAiPlayer(Player *value)
{
    aiPlayer = value;
    aiPlayer->setGameData(this);
}

Player *GameData::getHumanPlayer() const
{
    return humanPlayer;
}

void GameData::setHumanPlayer(Player *value)
{
    humanPlayer = value;
    humanPlayer->setGameData(this);
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

void GameData::cutForDeal()
{
    //activePlayer = rand() % 2 ? aiPlayer : humanPlayer;    
    aiPlayer->setOpponent(humanPlayer);
    humanPlayer->setOpponent(aiPlayer);

    activePlayer = aiPlayer;
    emit deckCut();
}

void GameData::dealCards()
{
    deck.shuffle();
    aiPlayer->dealtHand(deck.dealHand());
    humanPlayer->dealtHand(deck.dealHand());

    faceCard->setCard(deck.peekBottom());
    aiPlayer->getUnseen().haveSeen(deck.peekBottom());
    humanPlayer->getUnseen().haveSeen(deck.peekBottom());
    emit changedFaceCard();
    trumps = faceCard->getSuit();
    emit handsDealt();
}

void GameData::leadToTrick()
{
    if (activePlayer->isAi())
    {
        aisCard = activePlayer->playFirstCard();
        emit changedAisCard();
        switchActivePlayer();
        emit leadCardPlayed();
    }
    else
    {
        isPlayFirstCard = true;
        emit waitingForCard();
    }
}

void GameData::followToTrick()
{
    if (activePlayer->isAi())
    {
        aisCard = activePlayer->playFirstCard();
        emit changedAisCard();
        emit followedToTrick();
    }
   else
    {
        isPlayFirstCard = false;
        emit waitingForCard();
    }
}

void GameData::cardPlayed(int index, bool melded)
{
    if (isPlayFirstCard)
    {
        humansCard = activePlayer->playCard(index, melded);
        emit changedHumansCard();
        switchActivePlayer();
        emit leadCardPlayed();
    }
    else
    {
        humansCard = activePlayer->playCard(index, melded);
        emit changedHumansCard();
        emit followedToTrick();
    }
}

void GameData::meld()
{
    if (activePlayer == aiPlayer )
        activePlayer = humansCard->beats(*aisCard, trumps) ? humanPlayer : aiPlayer;
    else
        activePlayer = aisCard->beats(*humansCard, trumps) ? aiPlayer : humanPlayer;

    if (Card::Ace == humansCard->getRank() || Card::Ten == humansCard->getRank())
        activePlayer->incScore(10);
    if (Card::Ace == aisCard->getRank() || Card::Ten == aisCard->getRank())
        activePlayer->incScore(10);

    emit trickFinished();
    if (activePlayer->isAi())
    {
        activePlayer->meldAuto(trumps, meldedSeven);
        emit drawing();
       // finishTrick();
    }
    else
    {
        humanPlayer->getHand()->refreshMelds(trumps, meldedSeven);
        if (humanPlayer->canMeld())
            emit waitingForMeld();
        else
            emit drawing();
           // finishTrick();
    }
}

void GameData::endHand()
{

}

void GameData::endGame()
{

}

// call from qml
void GameData::humanMeld(bool meldMade, int index)
{
    if (meldMade)
    {
        humanPlayer->meldCard(index, trumps, meldedSeven);
        if (humanPlayer->canMeld())
            emit waitingForMeld();
        else
            emit drawing();
            //finishTrick();
    }
    else
        emit drawing();
       // finishTrick();
}

void GameData::finishTrick()
{
    humansCard = NULL;
    aisCard = NULL;

    int aiCardId = deck.dealTop();
    aiPlayer->giveCard(aiCardId);
    humanPlayer->getUnseen().haveSeen(aiCardId);

    int humanCardId = deck.dealTop();
    humanPlayer->giveCard(humanCardId);
    aiPlayer->getUnseen().haveSeen(humanCardId);
    qDebug() << "Deck size: " << deck.size();

    if (activePlayer->won())
        emit gameOver();
    else if (deck.empty())
    {
        ResetBoardForEndgame();
        emit startEndgame();
    }
    else
        emit melded();
}

void GameData::ResetBoardForEndgame()
{
    aiPlayer->getHand()->moveAllHidden();
    humanPlayer->getHand()->moveAllHidden();
}

BeziqueDeck *GameData::getDeck()
{
    return &deck;
}

bool GameData::getMeldedSeven() const
{
    return meldedSeven;
}

int GameData::getTrumps() const
{
    return trumps;
}

void GameData::switchActivePlayer()
{
    activePlayer = activePlayer == aiPlayer ? humanPlayer : aiPlayer;
}

void GameData::ScoreEndTrick()
{
    Card* firstCard = activePlayer->playFirstCardEndgame();
    switchActivePlayer();
    Card* secondCard = activePlayer->playSecondCardEndgame();

    activePlayer = firstCard->beats(*secondCard, trumps) ? aiPlayer : humanPlayer;
    if (Card::Ace == firstCard->getRank() || Card::Ten == firstCard->getRank())
        activePlayer->incScore(10);
    if (Card::Ace == secondCard->getRank() || Card::Ten == secondCard->getRank())
        activePlayer->incScore(10);

    if (activePlayer->won())
        emit gameOver();
    if (activePlayer->handEmpty())
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






























































