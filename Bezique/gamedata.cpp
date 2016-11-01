#include <QThread>

#include "gamedata.h"
#include "gamestate.h"
#include "aiplayer.h"
#include "controledplayer.h"
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

int GameData::getHumansCardIndex() const
{
    return humansCardIndex;
}

void GameData::setHumansCardIndex(int value)
{
    humansCardIndex = value;
}

int GameData::getAisCardIndex() const
{
    return aisCardIndex;
}

void GameData::setAisCardIndex(int value)
{
    aisCardIndex = value;
}

Player *GameData::getAiPlayer() const
{
    return aiPlayer;
}

void GameData::setAiPlayer(Player *value)
{
    aiPlayer = value;
}

Player *GameData::getHumanPlayer() const
{
    return humanPlayer;
}

void GameData::setHumanPlayer(Player *value)
{
    humanPlayer = value;
}

Card *GameData::getFaceCard() const
{
    return faceCard;
}
/*
BeziqueHand *GameData::playerHand() const
{
    return humanPlayer->getHand();
}

BeziqueHand *GameData::aiHand() const
{
    return aiPlayer->getHand();
}

void GameData::setPlayerHand(BeziqueHand *hand)
{
    humanPlayer->setHand(hand);
}

void GameData::setAiHand(BeziqueHand *hand)
{
    aiPlayer->setHand(hand);
}
*/
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
    activePlayer = aiPlayer;
    emit deckCut();
}

void GameData::dealCards()
{
    deck.shuffle();
    aiPlayer->dealtHand(deck.dealHand());
    humanPlayer->dealtHand(deck.dealHand());
    faceCard->setCard(deck.peekBottom());
    emit changedFaceCard();
    trumps = faceCard->getSuit();
    emit handsDealt();
}

void GameData::leadToTrick()
{
    if (activePlayer->isAi())
    {
        //aisCard = activePlayer->playFirstCard();
        aisCardIndex = activePlayer->playFirstCard();
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
        //aisCard = activePlayer->playFirstCard();
        aisCardIndex = activePlayer->playFirstCard();
        switchActivePlayer();
        emit followedToTrick();
    }
   else
    {
        isPlayFirstCard = false;
        emit waitingForCard();
    }
}

void GameData::cardPlayed(int index)
{
    if (isPlayFirstCard)
    {
        //firstCard = activePlayer->playCard(index);
        activePlayer->playCard(index);
        switchActivePlayer();
        emit leadCardPlayed();
    }
    else
    {
        //secondCard = activePlayer->playCard(index);
        activePlayer->playCard(index);
        emit followedToTrick();
    }
}
//Player* aiPlayer;
//Player* humanPlayer;
//int aisCardIndex;
//int humansCardIndex;
void GameData::meld()
{
    //activePlayer = firstCard->beats(*secondCard, trumps) ? aiPlayer : humanPlayer;
    const Card* playerCard = humanPlayer->getHand()->peek(humansCardIndex);
    const Card* aiCard = aiPlayer->getHand()->peek(aisCardIndex);
    if (activePlayer == aiPlayer )
        activePlayer = playerCard->beats(*aiCard, trumps) ? humanPlayer : aiPlayer;
    else
        activePlayer = aiCard->beats(*playerCard, trumps) ? aiPlayer : humanPlayer;

    if (Card::Ace == playerCard->getRank() || Card::Ten == playerCard->getRank())
        activePlayer->incScore(10);
    if (Card::Ace == aiCard->getRank() || Card::Ten == aiCard->getRank())
        activePlayer->incScore(10);
    //QThread::sleep(1);
    emit trickFinished();
    if (activePlayer->isAi())
    {
        activePlayer->meld();
    }
    else
    {
        emit waitingForMeld();
    }
    aiPlayer->giveCard(deck.dealTop(), aisCardIndex);
    humanPlayer->giveCard(deck.dealTop(), humansCardIndex);
    //QThread::sleep(1);
    if (activePlayer->won())
        emit gameOver();
    else if (deck.empty())
        emit startEndgame();
    else
        emit melded();
}
/*
void GameData::appendCard(QQmlListProperty<Card> *list, Card *card)
{
    return humanPlayer->getHand()->appendCard(list, card);
}

QQmlListProperty<Card> GameData::getCards()
{
    return humanPlayer->getHand()->getCards();
}
*/
void GameData::switchActivePlayer()
{
    activePlayer = activePlayer == aiPlayer ? humanPlayer : aiPlayer;
}

void GameData::playEndTrick()
{
    //Card* firstCard = activePlayer->playFirstCardEndgame();
   // switchActivePlayer();
   // Card* secondCard = activePlayer->playSecondCardEndgame();

    //activePlayer = firstCard->beats(*secondCard, trumps) ? aiPlayer : humanPlayer;
    //if (Card::Ace == firstCard->getRank() || Card::Ten == firstCard->getRank())
    //    activePlayer->incScore(10);
    //if (Card::Ace == secondCard->getRank() || Card::Ten == secondCard->getRank())
    //    activePlayer->incScore(10);

    if (activePlayer->won())
        emit gameOver();
    if (aiPlayer->handEmpty())
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















