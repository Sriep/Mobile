#include "beziquehand.h"

BeziqueHand::BeziqueHand(QQuickItem *parent)
    : QQuickItem(parent)
{
}

BeziqueHand::~BeziqueHand()
{
}

void BeziqueHand::resetCards(QList<int> newHand)
{
    cards.clear();
    for (int i = 0; i < newHand.size(); ++i) {
        Card* card = new Card(newHand[i]);
        cards.append(card);
    }
}

bool BeziqueHand::isEmpty() const
{
    return cards.empty();
}

void BeziqueHand::addCard(int cardId)
{
    Card* card = new Card(cardId);
    cards.append(card);
}

Card *BeziqueHand::peek(int index)
{
    return cards[index];
}

Card* BeziqueHand::playCard(int index)
{
    Card* playedCard = cards[index];
    cards.erase(cards.begin() + index);
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

void BeziqueHand::selectCard(int x, int y)
{

}

void BeziqueHand::appendCard(QQmlListProperty<Card> *list, Card *card)
{
    BeziqueHand *hand = qobject_cast<BeziqueHand*>(list->object);
    if (hand) {
        card->setParentItem(hand);
        hand->cards.append(card);
    }
}
























































