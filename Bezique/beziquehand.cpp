#include "beziquehand.h"
#include <QtDebug>

BeziqueHand::BeziqueHand(QQuickItem *parent)
    : QQuickItem(parent)//, isHidden(isHidden)
{

}

BeziqueHand::~BeziqueHand()
{
}

void BeziqueHand::resetCards(QList<int> newHand)
{
    if (newHand.size() > cards.size()) qFatal("Hand length mismatch");
    for (int i = 0; i < newHand.size(); ++i) {
        cards[i]->setCard(newHand[i]);
    }
}

bool BeziqueHand::isEmpty() const
{
    for (int i = 0; i < cards.size(); ++i) {
        if (!cards[i]->isCleard())
            return false;
    }
    return true;
}

void BeziqueHand::addCard(int cardId)
{
    cards.last()->setCard(cardId);
}

Card *BeziqueHand::peek(int index)
{
    return cards[index];
}

Card* BeziqueHand::playCard(int index)
{
    Card* playedCard = new Card(cards[index]);
    cards[index]->setCard(cards.last()->getCardId());
    cards.last()->setCard(playedCard->getCardId());
    return playedCard;
}

int BeziqueHand::getScore() const
{
    return playerScore;
}

void BeziqueHand::setScore(int value)
{
    if (playerScore != value)
    {
        playerScore = value;
        emit scoreChanged();
    }
}

void BeziqueHand::incScore(int amount)
{
    if ( amount != 0 )
    {
        playerScore += amount;
        emit scoreChanged();
    }
}

QQmlListProperty<Card> BeziqueHand::getCards()
{
    return QQmlListProperty<Card>(this, 0, &BeziqueHand::appendCard, 0, 0, 0);
}


void BeziqueHand::appendCard(QQmlListProperty<Card> *list, Card *card)
{
    BeziqueHand *hand = qobject_cast<BeziqueHand*>(list->object);
    if (hand) {
        card->setParentItem(hand);
        hand->cards.append(card);
    }
}
























































