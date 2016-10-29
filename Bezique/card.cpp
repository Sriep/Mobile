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
    emit imageChanged();
}

bool Card::beats(const Card &c, int trumps)
{
    if ( suit == c.suit ) return rank > c.rank;
    if ( c.suit == trumps ) return false;
    return true;
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
    return QString("content/gfx/" + suitStr[suit] + rankStr[rank] + ".bmp");
}

QString Card::getImage() const
{
    return imageFile;
}

void Card::setImage(QString image)
{
    imageFile = image;
}

