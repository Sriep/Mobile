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

Card* Player::playFirstCard()
{
    //hand->playCard(0);
    return hand->playCard(0);;
    //Card* playedCard = new Card(hand->cards[0]);
    //return playedCard;
}

Card* Player::playSecondCard()
{
    return playFirstCard();
}

Card *Player::playFirstCardEndgame()
{
    return playFirstCard();
}

Card* Player::playSecondCardEndgame()
{
    return playFirstCard();
}

void Player::meld()
{

}

void Player::giveCard(int iCard)
{
    hand->addCard(iCard);
}

void Player::incScore(int increment)
{
    score += increment;
}

Card* Player::playCard(int index, bool melded)
{
    return hand->playCard(index, melded);
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
