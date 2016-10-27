#include "player.h"

Player::Player(Game& game)
    : game(game), score(0)
{

}

void Player::dealtHand(vector<Card> dealtHand)
{
    hand = dealtHand;
}

Card Player::playFirstCard()
{
    Card card = hand.back();
    hand.pop_back();
    return card;
}

Card Player::playSecondCard()
{
    return playFirstCard();
}

Card Player::playFirstCardEndgame()
{
    return playFirstCard();
}

Card Player::playSecondCardEndgame()
{
    return playFirstCard();
}

void Player::meld()
{

}

void Player::giveCard(const Card &card)
{
    hand.push_back(card);
}

void Player::incScore(int increment)
{
    score += increment;
}

bool Player::handEmpty() const
{
    return hand.empty();
}

bool Player::won() const
{
    return score >= winningThreshold;
}
