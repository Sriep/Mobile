#include <QtDebug>
#include "card.h"

Card::Card()
{
}

Card::Card(int iCard, QQuickItem *parent)
    : QQuickItem(parent)
    , rank(iCard / 8)
    , suit(iCard % 4)
    , imageFile(getFilename(rank, suit))
    , link(EMPTY)
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

bool Card::beatsEnd(const Card &c, int trumps) const
{
    if ( suit == c.suit )
    {
        if (rank == Rank::Ten)
            return (c.rank < Rank::Jack || c.rank == Rank::Ten);
        if (c.rank == Rank::Ten)
            return (rank > Rank::Nine);
        return rank >= c.rank;
    }
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
    clearMeldStatus();
    emit cardChanged();
}

void Card::copyCard(const Card &card)
{
    rank = card.rank;
    suit = card.suit;
    cardId = card.cardId;
    imageFile = card.imageFile;
    link = card.link;

    canMeld = card.canMeld;
    canSeven = card.canSeven;
    canMarry = card.canMarry;
    canFlush = card.canFlush;
    canBezique = card.canBezique;
    canDoubleBezique = card.canDoubleBezique;
    canFourKind = card.canFourKind;

    hasMarried = card.hasMarried;
    hasBeziqued = card.hasBeziqued;
    hasDoubleBeziqued = card.hasDoubleBeziqued;
    hasFlushed = card.hasFlushed;
    hasFourKinded = card.hasFourKinded;

    emit cardChanged();
}

void Card::clearCard()
{
    rank = Rank::NumRanks;
    suit  = Suit::NumSuits;
    cardId = -1;
    imageFile = emptyBitmap;
    link = EMPTY;
    clearMeldStatus();
    emit cardChanged();
}

bool Card::isCleard()
{
    //return emptyBitmap == imageFile;
    return EMPTY == link || emptyBitmap == imageFile;
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
    //if (canMeld)
    //{
        canMeld = false;
        //emit canMeldChanged();
    //}
    canSeven = false;
    canMarry = false;
    canFlush = false;
    canBezique = false;
    canDoubleBezique = false;
    canFourKind = false;

    hasMarried = false;
    hasBeziqued = false;
    hasDoubleBeziqued = false;
    hasFlushed = false;
    hasFourKinded = false;
}

void Card::clearCanMeldStatus()
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
    canDoubleBezique = false;
    canFourKind = false;
}

void Card::setCanFourKind(bool value)
{
    if ( (rank == Rank::Seven || rank == Rank::Eight)
         || (rank == Rank::Nine && suit == Rank::Ten) )
        qFatal("assign four of a kind to ivalid rank");
    canFourKind = value;
}

void Card::setCanDoubleBezique(bool value)
{
    if ( !(  (rank == Rank::Jack && suit == Suit::Diamonds)
         || (rank == Rank::Queen && suit == Suit::Spades) ) )
        qFatal("assign double beziqe to non bezique card");
    canDoubleBezique = value;
}

void Card::setCanBezique(bool value)
{
    if ( !(  (rank == Rank::Jack && suit == Suit::Diamonds)
         || (rank == Rank::Queen && suit == Suit::Spades)
       ) )
        qFatal("assign double beziqe to non bezique card");
    canBezique = value;
}

void Card::setCanFlush(bool value)
{
    canFlush = value;
}

void Card::setCanMarry(bool value)
{
    if ( rank != Rank::King && rank != Rank::Queen )
        qFatal("assign marrage to non king or queen");
    canMarry = value;
}

void Card::setCanSeven(bool value)
{
    if ( rank != Rank::Seven )
        qFatal("assign senven to non seven");
    canSeven = value;
}

void Card::setHasFourKinded(bool value)
{
    if ( (rank == Rank::Seven || rank == Rank::Eight)
         || (rank == Rank::Nine && suit == Rank::Ten) )
        qFatal("assign four of a kind to ivalid rank");
    hasFourKinded = value;
}

void Card::dump()
{
    QString dump = rankName[rank] + suitStr[suit];
    dump += " link " + QString::number(link);
    dump += canMeld ? "canMeld, " : "";
    dump += hasMarried ? "hasMarried, " : "";
    dump += hasBeziqued ? "hasBeziqued, " : "";
    dump += hasDoubleBeziqued ? "hasDoubleBeziqued, " : "";
    dump += hasFlushed ? "hasFlushed, " : "";
    dump += hasFourKinded ? "hasFourKinded, " : "";

    dump += canSeven ? "canSeven, " : "";
    dump += canMarry ? "canMarry, " : "";
    dump += canFlush ? "canFlush, " : "";
    dump += canBezique ? "canBezique, " : "";
    dump += canDoubleBezique ? "canDoubleBezique, " : "";
    dump += canFourKind ? "canFourKind, " : "";
    qDebug() << dump;
}

void Card::setHasFlushed(bool value)
{
    hasFlushed = value;
}

void Card::setHasDoubleBeziqued(bool value)
{
    if ( !(  (rank == Rank::Jack && suit == Suit::Diamonds)
         || (rank == Rank::Queen && suit == Suit::Spades) ) )
        qFatal("assign double beziqe to non bezique card");
    hasDoubleBeziqued = value;
}

void Card::setHasBeziqued(bool value)
{
    if ( !(  (rank == Rank::Jack && suit == Suit::Diamonds)
         || (rank == Rank::Queen && suit == Suit::Spades)
       ) )
        qFatal("assign double beziqe to non bezique card");
    hasBeziqued = value;
}

void Card::setHasMarried(bool value)
{
    if (  (rank != Rank::King && rank != Rank::Queen) )
        qFatal("assign marrage to non king or queen");
    hasMarried = value;
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



























