#include <QtDebug>
#include "card.h"
/*
void Card::cardPlayed(int index, int x, int y)
{
    qDebug("Mouse pressed");
}*/

Card::Card()
{
}

Card::Card(int iCard, QQuickItem *parent)
    : QQuickItem(parent)
    , rank(iCard / 8)
    , suit(iCard % 4)
    , imageFile(getFilename(rank, suit))
    , link(0)
    , cardId(iCard)
{
}

Card::Card(const Card *card, QQuickItem *parent)
    : QQuickItem(parent)
    , rank(card->rank)
    , suit(card->suit)
    , imageFile(card->imageFile)
    , link(card->link)
    , cardId(card->cardId)
{

}

Card::Card(const Card &card, QQuickItem *parent)
    : QQuickItem(parent)
    , rank(card.rank)
    , suit(card.suit)
    , imageFile(card.imageFile)
    , link(card.link)
    , cardId(card.cardId)
{
}

bool Card::beats(const Card &c, int trumps) const
{
    if ( suit == c.suit )
        return rank >= c.rank;
    if ( c.suit == trumps )
        return false;
    return true;
}

void Card::setCard(int cardId, int newLink)
{
    rank = cardId / 8;
    suit  = (Suit) (cardId % 4);
    cardId = cardId;
    imageFile = getFilename(rank, suit);
    link = newLink;
    emit cardChanged();
}

void Card::copyCard(const Card &card)
{
    rank = card.rank;
    suit = card.suit;
    cardId = card.cardId;
    imageFile = card.imageFile;
    link = card.link;
    emit cardChanged();
}

void Card::clearCard()
{
    rank = -1;
    suit  = Suit::NumSuits;
    cardId = -1;
    imageFile = emptyBitmap;
    link = EMPTY;
    emit cardChanged();
}

bool Card::isCleard()
{
    return emptyBitmap == imageFile;
    //return EMPTY == link;
}

int Card::getRank() const
{
    return rank;
}

int Card::getSuit() const
{
    return suit;
}

QString Card::getName() const
{
    return QString(rankName[rank] + suitStr[suit]);
}

QString Card::getFilename(int rank, int suit)
{
    if (Rank::NumRanks > rank && Suit::NumSuits > suit
          && 0 <= rank && 0 <= suit  )
    {
       // return QString("content/gfx/" + suitStr[suit] + rankStr[rank] + ".bmp");
        QString path("content/gfx/tinydeck/");
        QString name = path + rankStr[rank] + suitStr[suit] + ".gif";
        return name;
    }
    else
    {
        qWarning("rank or suit out of range in Card::getFilename");
        return emptyBitmap;
    }
}

void Card::clearMeldStatus()
{
    if (canMeld)
    {
        canMeld = false;
        emit canMeldChanged();
    }
    canSeven = false;
    canMarry = false;
    canFlush = false;
    canBezique = false;
    canFourKind = false;
}

bool Card::getCanMeld() const
{
    return canMeld;
}

void Card::setCanMeld(bool value)
{
    if (canMeld != value)
    {
        canMeld = value;
        emit canMeldChanged();
    }
}

int Card::getLink() const
{
    return link;
}

void Card::setLink(int value)
{
    link = value;
}

void Card::setSuit(int value)
{
    suit = (Suit) value;
}

void Card::setRank(int value)
{
    rank = value;
}

int Card::getCardId() const
{
    return cardId;
}

QString Card::getImage() const
{
    return imageFile;
}

void Card::setImage(QString image)
{
    if (imageFile != image)
    {
         imageFile = image;
         emit cardChanged();
    }


}



























