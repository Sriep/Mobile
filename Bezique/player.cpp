#include "player.h"
#include "aievaluate.h"

Player::Player(QQuickItem *parent)
    : QQuickItem(parent), score(0)
{
}


void Player::init()
{
}

Player *Player::getOpponent() const
{
    return opponent;
}

void Player::setOpponent(Player *value)
{
    opponent = value;
}

UnseenCards Player::getUnseen()
{
    return unseen;
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
    unseen.haveSeenHand(hand);
}

int Player::semiRandomCard() const
{
/*    int minRank = 15;
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
        return (int) hand->playCard(meldedId, true);

    int hiddenId = hand->findLinkHidden(index);
    if (hiddenId != BeziqueHand::NOT_FOUND)
        return (int) hand->playCard(hiddenId, false);*/
    return 0;
}

void Player::setGameData(GameData *value)
{
    gameData = value;
}

Card* Player::playFirstCard()
{
    AiEvaluate aiEvaluate(hand
                           , opponent->hand->meldedCardList()
                           , &unseen
                           , gameData
                         );
    return hand->playCard(aiEvaluate());
}

Card* Player::playSecondCard()
{
    return playFirstCard();
}

Card *Player::playFirstCardEndgame()
{
    return hand->playCard(semiRandomCard());
}

Card* Player::playSecondCardEndgame()
{
    return hand->playCard(semiRandomCard());
}

void Player::meldAuto(int trumps, bool seven)
{
    hand->refreshMelds(trumps, seven);
    meldRecursive(trumps, seven);
}

void Player::meldRecursive(int trumps, bool seven)
{
    bool melded = false;
    int index = 0;
    while(!melded && index < BeziqueHand::HAND_SIZE)
    {
        if (hand->cards[index]->getCanMeld())
        {
            meldCard(index, trumps, seven);
            melded = true;
        }
        index++;
    }
    if (melded) meldAuto(trumps, seven);
}

void Player::meldCard(int index, int trumps, bool seven)
{
    incScore(hand->meld(index, opponent));
    hand->refreshMelds(trumps, seven);
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

bool Player::canMeld()
{
    QList<Card*>::const_iterator i;
    for ( i = hand->cards.constBegin() ; i != hand->cards.constEnd() ; ++i )
        if ((**i).getCanMeld())
            return true;
    return false;
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
