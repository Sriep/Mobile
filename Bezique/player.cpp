#include "player.h"

Player::Player(QQuickItem *parent)
    : QQuickItem(parent), score(0)
{
    //init();
}

//Player::Player()
//{
//    //init();
//}

void Player::init()
{
   // hand = new BeziqueHand();
}

void Player::setAi(bool value)
{
    ai = value;
}

bool Player::isAi() const
{
    return ai;
}

void Player::dealtHand(QList<int> dealtHand)
{
    hand->resetCards(dealtHand);
}

int Player::playFirstCard()
{
    hand->playCard(0);
    return 0;
    //Card* playedCard = new Card(hand->cards[0]);
    //return playedCard;
}

int Player::playSecondCard()
{
    return playFirstCard();
}

int Player::playFirstCardEndgame()
{
    return playFirstCard();
}

int Player::playSecondCardEndgame()
{
    return playFirstCard();
}

void Player::meld()
{

}

void Player::giveCard(int iCard, int index)
{
    hand->addCard(iCard, index);
}

void Player::incScore(int increment)
{
    score += increment;
}

Card* Player::playCard(int index)
{
    return hand->playCard(index);
}

int Player::getScore() const
{
    return score;
}

void Player::setScore(int value)
{
    score = value;
}

BeziqueHand *Player::getHand() const
{
    return hand;
}

void Player::setHand(BeziqueHand *value)
{
    hand = value;
}

bool Player::handEmpty() const
{
    return hand->isEmpty();
}

bool Player::won() const
{
    return score >= winningThreshold;
}
