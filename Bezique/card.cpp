#include <QtDebug>
#include "card.h"

void Card::cardPlayed(int index, int x, int y)
{
    qDebug("Mouse pressed");
    //qDebug  << "Mouse pressed index " << index;
}

Card::Card(QQuickItem *parent)
    : QQuickItem(parent)
{
}

Card::Card(int iCard, QQuickItem *parent)
    : QQuickItem(parent)
    , rank(iCard / 8)
    , suit(iCard % 4)
    , cardId(iCard)
    , imageFile(getFilename(rank, suit))
{
}

Card::Card(const Card &card, QQuickItem *parent)
    : QQuickItem(parent)
    , rank(card.rank)
    , suit(card.suit)
    , cardId(card.cardId)
    , imageFile(card.imageFile)
{
}

bool Card::beats(const Card &c, int trumps) const
{
    if ( suit == c.suit ) return rank > c.rank;
    if ( c.suit == trumps ) return false;
    return true;
}

void Card::setCard(int cardId)
{
    rank = cardId / 8;
    suit  = cardId % 4;
    cardId = cardId;
    imageFile = getFilename(rank, suit);
    emit cardChanged();
}

void Card::clearCard()
{
    rank = -1;
    suit  = -1;
    cardId = -1;
    imageFile = emptyBitmap;
    emit cardChanged();
}

bool Card::isCleard()
{
    return emptyBitmap == imageFile;
}

int Card::getRank() const
{
    return rank;
}

int Card::getSuit() const
{
    return suit;
}

QString Card::getFilename(int rank, int suit)
{
    if (Rank::NumRanks > rank && Suit::NumSuits > suit
          && 0 <= rank && 0 <= suit  )
        return QString("content/gfx/" + suitStr[suit] + rankStr[rank] + ".bmp");
    else
    {
        qWarning("rank or suit out of range in Card::getFilename");
        return emptyBitmap;
    }
}

void Card::setSuit(int value)
{
    suit = value;
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



























