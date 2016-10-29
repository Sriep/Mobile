#include "player.h"

Player::Player(QQuickItem *parent)
    : QQuickItem(parent), score(0)
{

}

void Player::dealtHand(QList<int> dealtHand)
{
    hand.resetCards(dealtHand);
}

Card* Player::playFirstCard()
{
    return hand.playCard(0);
    //Card card = hand.cards.back();
    //hand.cards.pop_back();
    //return card;
}

Card* Player::playSecondCard()
{
    return playFirstCard();
}

Card* Player::playFirstCardEndgame()
{
    return playFirstCard();
}

Card *Player::playSecondCardEndgame()
{
    return playFirstCard();
}

void Player::meld()
{

}

void Player::giveCard(int iCard)
{
    //hand.cards.push_back(card);
    hand.addCard(iCard);
}

void Player::incScore(int increment)
{
    score += increment;
}

Card* Player::playCard(int index)
{
    return hand.playCard(index);
}

int Player::getScore() const
{
    return score;
}

void Player::setScore(int value)
{
    score = value;
}

bool Player::handEmpty() const
{
    return hand.isEmpty();
    //return hand.cards.empty();
}

bool Player::won() const
{
    return score >= winningThreshold;
}
