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
    //if (newHand.size() > cards.size()) qFatal("Hand length mismatch");
    //for (int i = 0; i < newHand.size(); ++i) {
    //    cards[i]->setCard(newHand[i]);
    //}
    if (newHand.size() > cards.size()) qFatal("Hand length mismatch");
    for (int i = 0; i < newHand.size(); ++i) {
        cards[i]->setCard(newHand[i], i);
        hiddedCards[i]->setCard(newHand[i], i);
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
    //cards.at(index)->setCard(cardId);
    int iCard = 0;
    while ( cards[iCard]->getLink() < HAND_SIZE && iCard < HAND_SIZE )
        iCard++;
    cards.at(iCard)->setCard(cardId, iCard);

    int iHide = 0;
    while ( hiddedCards[iHide]->getLink() < HAND_SIZE && iHide < HAND_SIZE )
        iHide++;
    hiddedCards.at(iHide)->setCard(cardId, iCard);
}

const Card *BeziqueHand::peek(int index)
{
    return cards[index];
}

Card* BeziqueHand::playCard(int index, bool melded)
{
    int link = findLink(index, melded);
    Card* playedCard;
    if (melded)
    {
        playedCard = new Card( meldedCards[link] );
        meldedCards[index]->clearCard();
    }
    else
    {
        playedCard = new Card( hiddedCards[link]);
        hiddedCards[index]->clearCard();
    }
    cards[link]->clearCard();
    //Card* playedCard = new Card( melded ? meldedCards[link] : hiddedCards[link]);
    //melded ? meldedCards[index]->clearCard() : hiddedCards[index]->clearCard();

    emit enginPlayedCard(index);
    return playedCard;
}

int BeziqueHand::findLink(int index, bool melded)
{
    QList<Card*>& list = melded ? meldedCards : hiddedCards;
    for ( int i = 0 ; i < list.size() ; i++)
    {
        if (list[i]->getLink() == index)
            return i;
    }
    return -1;
}



/*
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
*/
QQmlListProperty<Card> BeziqueHand::getCards()
{
    return QQmlListProperty<Card>(this, 0, &BeziqueHand::appendCard, 0, 0, 0);
}

QQmlListProperty<Card> BeziqueHand::getMeldedCards()
{
    return QQmlListProperty<Card>(this, 0, &BeziqueHand::appendMeldedCard, 0, 0, 0);
}

QQmlListProperty<Card> BeziqueHand::getHiddenCards()
{
    return QQmlListProperty<Card>(this, 0, &BeziqueHand::appendHiddenCard, 0, 0, 0);
}


void BeziqueHand::appendCard(QQmlListProperty<Card> *list, Card *card)
{
    BeziqueHand *hand = qobject_cast<BeziqueHand*>(list->object);
    if (hand) {
        card->setParentItem(hand);
        hand->cards.append(card);
    }
}

void BeziqueHand::appendMeldedCard(QQmlListProperty<Card> *list, Card *card)
{
    BeziqueHand *hand = qobject_cast<BeziqueHand*>(list->object);
    if (hand) {
        card->setParentItem(hand);
        hand->meldedCards.append(card);
    }
}

void BeziqueHand::appendHiddenCard(QQmlListProperty<Card> *list, Card *card)
{
    BeziqueHand *hand = qobject_cast<BeziqueHand*>(list->object);
    if (hand) {
        card->setParentItem(hand);
        hand->hiddedCards.append(card);
    }
}
























































