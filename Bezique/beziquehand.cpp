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
    Card* playedCard;
    if (melded)
    {
        playedCard = new Card( meldedCards[index] );
        cards[meldedCards[index]->getLink()]->clearCard();
        meldedCards[index]->clearCard();
    }
    else
    {
        playedCard = new Card( hiddedCards[index]);
        cards[hiddedCards[index]->getLink()]->clearCard();
        hiddedCards[index]->clearCard();
    }

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

void BeziqueHand::refreshMelds(int trumps, bool seven)
{
    for ( int i = 0 ; i < cards.size() ; i++ )
    {
        cards[i]->clearMeldStatus();
    }
    for ( int i = 0 ; i < cards.size() ; i++ )
    {
        cards[i]->setCanMeld(canMeld(i, trumps, seven));
    }
}

bool BeziqueHand::canMeld(int index, int trumps, bool seven) const
{
    switch (cards[index]->getRank()) {
    case Card::Rank::Seven:
        if (cards[index]->getSuit() == trumps && seven)
        {
            cards[index]->canSeven = true;
            return true;
        }
        break;
    case Card::Rank::Jack:
        return canMeldJack(index, trumps);
    case Card::Rank::Queen:
        return canMeldQueen(index, trumps);
    case Card::Rank::King:
        return canMeldKing(index, trumps);
    case Card::Rank::Ten:
        return canMeldTen(index, trumps);
    case Card::Rank::Ace:
        return canMeldAce(index, trumps);
    default:
        break;
    }
    return false;
}

bool BeziqueHand::canMeldJack(int index, int trumps) const
{
    int countJacks =1;
    bool canMeld = false;
    bool flush[5] = {true, false, false, false, false};
    for ( int i = 0 ; i < cards.size() ; i++ )
    {
        if (index != i && cards[i]->getLink() != Card::EMPTY)
        {
            switch (cards[i]->getRank()) {
            case Card::Rank::Jack:
                if (!cards[i]->hasFourKinded)
                    countJacks++;
                break;
            case Card::Rank::Queen:
                if (Card::Suit::Spades == cards[i]->getSuit()
                        && Card::Suit::Diamonds == cards[index]->getSuit()
                        && !cards[i]->hasBeziqued
                        && !cards[index]->hasBeziqued)
                {
                    cards[index]->canBezique = true;
                    canMeld = true;
                }
                if (!cards[i]->hasFlushed)
                    flush[1] = true;
            case Card::Rank::King:
            case Card::Rank::Ten:
            case Card::Rank::Ace:
                if (cards[i]->getSuit() == trumps
                        && false == cards[i]->hasFlushed)
                    flush[cards[i]->getRank() - CONVERT_FLUSH_INDEX] = true;
            default:
                break;
            }
        }
    }
    if (countJacks >= 4 && !cards[index]->hasFourKinded)
    {
        cards[index]->canFourKind = true;
        canMeld = true;
    }
    if (flush[0] && flush[1] && flush[2] && flush[3] && flush[4]
            && !cards[index]->hasFlushed
            && cards[index]->getSuit() == trumps)
    {
        cards[index]->canFlush = true;
        canMeld = true;
    }

    return canMeld;
}

bool BeziqueHand::canMeldQueen(int index, int trumps) const
{
    int countQueens =1;
    bool canMeld = false;
    bool flush[5] = {false, true, false, false, false};
    for ( int i = 0 ; i < cards.size() ; i++ )
    {
        if (index != i && cards[i]->getLink() != Card::EMPTY)
        {
            switch (cards[i]->getRank()) {
            case Card::Rank::Jack:
                if (Card::Suit::Diamonds == cards[i]->getSuit()
                        && Card::Suit::Spades == cards[index]->getSuit()
                        && !cards[i]->hasBeziqued
                        && !cards[index]->hasBeziqued)
                {
                    cards[index]->canBezique = true;
                    canMeld = true;
                }
                if (!cards[i]->hasFlushed)
                    flush[1] = true;
                break;
            case Card::Rank::Queen:
                if (false == cards[i]->hasFourKinded)
                    countQueens++;
                break;
            case Card::Rank::King:
                if (cards[i]->getSuit() == cards[index]->getSuit()
                        && !cards[i]->hasMarried
                        && !cards[index]->hasMarried)
                {
                    cards[index]->canMarry = true;
                    canMeld = true;
                }
            case Card::Rank::Ten:
            case Card::Rank::Ace:
                if (cards[i]->getSuit() == trumps
                        && !cards[i]->hasFlushed)
                    flush[cards[i]->getRank() - CONVERT_FLUSH_INDEX] = true;
            default:
                break;
            }
        }
    }
    if (countQueens >= 4 && !cards[index]->hasFourKinded)
    {
        cards[index]->canFourKind = true;
        canMeld = true;
    }
    if (flush[0] && flush[1] && flush[2] && flush[3] && flush[4]
            && !cards[index]->hasFlushed
            && cards[index]->getSuit() == trumps)
    {
        cards[index]->canFlush = true;
        canMeld = true;
    }
    return canMeld;
}

bool BeziqueHand::canMeldKing(int index, int trumps) const
{
    int countKings =1;
    bool canMeld = false;
    bool flush[5] = {false, false, true, false, false};
    for ( int i = 0 ; i < cards.size() ; i++ )
    {
        if (index != i && cards[i]->getLink() != Card::EMPTY)
        {
            switch (cards[i]->getRank()) {
            case Card::Rank::King:
                if (!cards[i]->hasFourKinded)
                    countKings++;
                break;
            case Card::Rank::Queen:
                if (cards[i]->getSuit() == cards[index]->getSuit()
                        && !cards[i]->hasMarried
                        && !cards[index]->hasMarried
                        && !cards[index]->hasMarried)
                {
                    cards[index]->canMarry = true;
                    canMeld = true;
                }
            case Card::Rank::Jack:
            case Card::Rank::Ten:
            case Card::Rank::Ace:
                if (cards[i]->getSuit() == trumps
                        && !cards[i]->hasFlushed)
                    flush[cards[i]->getRank() - CONVERT_FLUSH_INDEX] = true;
            default:
                break;
            }
        }
    }
    if (countKings >= 4 && !cards[index]->hasFourKinded)
    {
        cards[index]->canFourKind = true;
        canMeld = true;
    }
    if (flush[0] && flush[1] && flush[2] && flush[3] && flush[4]
            && !cards[index]->hasFlushed && cards[index]->getSuit() == trumps)
    {
        cards[index]->canFlush = true;
        canMeld = true;
    }
    return canMeld;
}

bool BeziqueHand::canMeldTen(int index, int trumps) const
{

    if (cards[index]->hasFlushed) return false;
    bool flush[5] = {false, false, false, true, false};
    for ( int i = 0 ; i < cards.size() ; i++ )
    {
        if (index != i && cards[i]->getLink() != Card::EMPTY)
        {
            switch (cards[i]->getRank()) {
            case Card::Rank::Jack:
            case Card::Rank::Queen:
            case Card::Rank::King:
            case Card::Rank::Ten:
            case Card::Rank::Ace:
                if (cards[i]->getSuit() == trumps
                        && !cards[i]->hasFlushed)
                    flush[cards[i]->getRank() - CONVERT_FLUSH_INDEX] = true;
            default:
                break;
            }
        }
    }
    if (flush[0] && flush[1] && flush[2] && flush[3] && flush[4]
            && !cards[index]->hasFlushed && cards[index]->getSuit() == trumps)
    {
        cards[index]->canFlush = true;
        return true;
    }
    return false;
}

bool BeziqueHand::canMeldAce(int index, int trumps) const
{
    int countAces =1;
    bool canMeld = false;
    bool flush[5] = {false, false, false, false, true};
    for ( int i = 0 ; i < cards.size() ; i++ )
    {
        if (index != i && cards[i]->getLink() != Card::EMPTY)
        {
            switch (cards[i]->getRank()) {
            case Card::Rank::Ace:
                if (!cards[i]->hasFourKinded)
                    countAces++;
                break;
            case Card::Rank::Jack:
            case Card::Rank::Queen:
            case Card::Rank::King:
            case Card::Rank::Ten:
                if (cards[i]->getSuit() == trumps
                        && !cards[i]->hasFlushed)
                    flush[cards[i]->getRank() - CONVERT_FLUSH_INDEX] = true;
            default:
                break;
            }
        }
    }
    if (countAces >= 4 && !cards[index]->hasFourKinded)
    {
        cards[index]->canFourKind = true;
        canMeld = true;
    }
    if (flush[0] && flush[1] && flush[2] && flush[3] && flush[4]
            && !cards[index]->hasFlushed
            && cards[index]->getSuit() == trumps)
    {
        cards[index]->canFlush = true;
        canMeld = true;
    }
    return canMeld;
}

int BeziqueHand::meld(int index)
{
    if (!cards[index]->canMeld) qWarning("melding not possable");

    //int ii = index;
    //QList<int> m;
    //m.append(ii);

    QList<int> meld;
    meld.append(index);
    int score = 0;
    if (cards[index]->canSeven) score = SCORE_SEVEN;
    else if (cards[index]->canFlush) score = findFlush(meld);
    else if (cards[index]->canBezique) score = findBezique(meld);
    else if (cards[index]->canFourKind) score = findFourKind(meld);
    else if (cards[index]->canMarry) score = findMarrage(meld);

    moveMelded(meld, score);
    return score;
}

int BeziqueHand::findFlush(QList<int> &meld) const
{
    bool flush[5] = {false, false, false, false, false};
    flush[meld.first() - CONVERT_FLUSH_INDEX] = true;
    int trumps = cards[meld.first()]->getSuit();

    for (int i = 0 ; i < HAND_SIZE ; i++)
    {
        if (cards[i]->getSuit() == trumps)
        {
            if (cards[i]->getRank() >= Card::Rank::Jack
                   && !flush[cards[i]->getRank() == CONVERT_FLUSH_INDEX]
                   && cards[i]->canFlush)
            {
                flush[cards[i]->getRank() == CONVERT_FLUSH_INDEX] = true;
                meld.append(i);
                cards[i]->hasFlushed = true;
            }
        }
    }
    return SCORE_FLUSH;
}

int BeziqueHand::findBezique(QList<int> &meld) const
{
    int findRank = cards[meld.first()]->getRank() == Card::Rank::Jack ?
                Card::Rank::Queen : Card::Rank::Jack;
    int findSuit = cards[meld.first()]->getSuit() == Card::Suit::Spades ?
                Card::Suit::Diamonds : Card::Suit::Spades;
    for (int i = 0 ; i < HAND_SIZE ; i++ )
    {
        if (cards[i]->getRank() == findRank
                && cards[i]->getSuit() == findSuit
                && cards[i]->canBezique)
        {
            meld.append(i);
            cards[i]->hasBeziqued =  true;
            return SCORE_BEZIQUE;
        }
    }
}

int BeziqueHand::findFourKind(QList<int> &meld) const
{
    int rankMatches = 1;
    int rank = cards[meld.first()]->getRank();
    int i = 0;
    while ( i < HAND_SIZE && rankMatches < 4 )
    {
        if (cards[i]->getRank() == rank
                && i != meld.first()
                && cards[i]->canFourKind)
        {
            meld.append(i);
            cards[i]->hasFourKinded = true;
            rankMatches++;
        }
        i++;
    }
    switch (rank) {
    case Card::Rank::Jack:
        return SCORE_FOURK_JACKS;
    case Card::Rank::Queen:
        return SCORE_FOURK_QUEENS;
    case Card::Rank::King:
        return SCORE_FOURK_KINGS;
    case Card::Rank::Ace:
        return SCORE_FOURK_ACES;
    default:
        break;
    }
}

int BeziqueHand::findMarrage(QList<int> &meld) const
{
    int findRank = cards[meld.first()]->getRank() == Card::Rank::Queen ?
                Card::Rank::King : Card::Rank::Queen;
    int findSuit = cards[meld.first()]->getSuit();
    for ( int i = 0 ; i < HAND_SIZE ; i++ )
    {
        if (cards[i]->getRank() == findRank
                && cards[i]->getSuit() == findSuit
                && cards[i]->canMarry)
        {
            meld.append(i);
            cards[i]->hasMarried = true;
            return SCORE_MARRAGE;
        }
    }
}

void BeziqueHand::moveMelded(const QList<int> &meld, int score)
{
   // QList<int>::const_iterator i;
    for ( QList<int>::const_iterator  i = meld.begin(); i != meld.end(); ++i )
    {
        int hiddenId = findLinkHidden(*i) ;
        if (hiddenId != NOT_FOUND)
        {
            moveHiddenMelded(hiddenId);
        }
        else
        {
        }
    }
}

void BeziqueHand::moveHiddenMelded(int index)
{
    int iMerge = 0;
    while ( meldedCards[iMerge]->getLink() < HAND_SIZE
            && iMerge < HAND_SIZE )
        iMerge++;
    meldedCards[iMerge]->copyCard(*hiddedCards[index]);
    hiddedCards[index]->clearCard();
}

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

int BeziqueHand::findLinkHidden(int link) const
{
    for ( int i = 0 ; i < HAND_SIZE ; i++ )
    {
        if (hiddedCards[i]->getLink() == link)
            return i;
    }
    return NOT_FOUND;
}

int BeziqueHand::findLinkMelded(int link) const
{
    for ( int i = 0 ; i < HAND_SIZE ; i++ )
    {
        if (meldedCards[i]->getLink() == link)
            return i;
    }
    return NOT_FOUND;
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
























































