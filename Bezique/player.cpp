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
    int minRank = 15;
    int index = 0;
    for ( int i = 0 ; i < BeziqueHand::HAND_SIZE ; i++ )
    {
        if (hand->cards[i]->getRank() == Card::Rank::Ten)
        {
            index = i;
            break;
        }

        if ( hand->cards[i]->getRank() < minRank)
        {
            index = i;
            minRank = hand->cards[i]->getRank();
        }
    }

    int meldedId = hand->findLinkMelded(index);
    if (meldedId != BeziqueHand::NOT_FOUND)
        return hand->playCard(meldedId, true);

    int hiddenId = hand->findLinkHidden(index);
    if (hiddenId != BeziqueHand::NOT_FOUND)
        return hand->playCard(hiddenId, false);

    return hand->playCard(index);
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

void Player::meld(int trumps, bool seven)
{
    hand->refreshMelds(trumps, seven);
    bool melded = false;
    int index = 0;
    while(!melded && index < BeziqueHand::HAND_SIZE)
    {
        if (hand->cards[index]->getCanMeld())
        {
            hand->meld(index);
            melded = true;
        }
        index++;
    }
    if (melded) meld(trumps, seven);
}

void Player::giveCard(int iCard)
{
    hand->addCard(iCard);
}

void Player::incScore(int increment)
{
    score += increment;
    if (increment != 0)
        emit scoreChanged();
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
    if (score != value)
        emit scoreChanged();
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
