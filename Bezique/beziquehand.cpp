#include <QtDebug>


#include "beziquehand.h"
#include "player.h"
#include "unseencards.h"

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
    while ( iCard < HAND_SIZE && cards[iCard]->getLink() < HAND_SIZE )
        iCard++;
    cards.at(iCard)->setCard(cardId, iCard);

    int iHide = 0;
    while ( iHide < HAND_SIZE && hiddedCards[iHide]->getLink() < HAND_SIZE )
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
        bool can = canMeld(i, trumps, seven);
        cards[i]->setCanMeld(can);
        int hiddenLink = findLinkHidden(i);
        if (hiddenLink != NOT_FOUND)
            hiddedCards[i]->setCanMeld(can);
        else
        {
            int meldedLink = findLinkMelded(i);
            if (meldedLink != NOT_FOUND)
                meldedCards[meldedLink]->setCanMeld(can);
        }
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

int BeziqueHand::meld(int index, Player* opponent)
{
    if (!cards[index]->canMeld) qWarning("melding not possable");

    QList<int> meld;
    meld.append(index);
    int score = 0;
    if (cards[index]->canSeven) score = SCORE_SEVEN;
    else if (cards[index]->canFlush) score = findFlush(meld);
    else if (cards[index]->canBezique) score = findBezique(meld);
    else if (cards[index]->canFourKind) score = findFourKind(meld);
    else if (cards[index]->canMarry) score = findMarrage(meld);

    moveMelded(meld, opponent);
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
    cards[meld.first()]->hasFlushed = true;
    return SCORE_FLUSH;
}

int BeziqueHand::findBezique(QList<int> &meld) const
{
    cards[meld.first()]->hasBeziqued = true;
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
    qWarning() << "End of BeziqueHand::findBezique, no bezique found.";
    return 0;
}

int BeziqueHand::findFourKind(QList<int> &meld) const
{
    cards[meld.first()]->hasFourKinded = true;
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
        return SCORE_FOUR_JACKS;
    case Card::Rank::Queen:
        return SCORE_FOUR_QUEENS;
    case Card::Rank::King:
        return SCORE_FOUR_KINGS;
    case Card::Rank::Ace:
        return SCORE_FOUR_ACES;
    default:
        break;
    }
    qWarning() << "End of BeziqueHand::findFourKind, no findFourKind found.";
    return 0;
}

int BeziqueHand::findMarrage(QList<int> &meld) const
{
    cards[meld.first()]->hasMarried = true;
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
    qWarning() << "End of BeziqueHand::findMarrage, no Marrage found.";
    return 0;
}

void BeziqueHand::moveMelded(const QList<int> &meld, Player* player)
{
   // QList<int>::const_iterator i;
    for ( QList<int>::const_iterator  i = meld.begin(); i != meld.end(); ++i )
    {
        int hiddenId = findLinkHidden(*i) ;
        if (hiddenId != NOT_FOUND)
        {
            moveHiddenMelded(hiddenId);
            if (player)
            {
                player->getUnseen().haveSeen(*cards[*i]);
            }
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

void BeziqueHand::moveMeldedHidden(int index)
{
    int iHide = 0;
    while ( hiddedCards[iHide]->getLink() < HAND_SIZE
            && iHide < HAND_SIZE )
        iHide++;
    hiddedCards[iHide]->copyCard(*hiddedCards[index]);
    meldedCards[index]->clearCard();
}

void BeziqueHand::moveAllHidden()
{
    for ( int i = 0 ; i < meldedCards.size() ; i++ )
    {
        if (meldedCards[i]->getLink() != Card::EMPTY)
        {
            moveMeldedHidden(i);
        }
    }
}

int BeziqueHand::scoreMelds(int trumps) const
{
    int score = 0;
    bool bezique = false;
    bool flush = false;
    bool doubleBezique = false;
    int marrage[Card::Suit::NumSuits] = {false, false, false, false};
    bool fourKind[5] = {false, false, false, false, false};

    for ( int i=0 ; i<cards.length() ; i++ )
    {
        if (cards[i]->canBezique) bezique = true;
        if (cards[i]->canFlush) flush = true;
        if (cards[i]->canDoubleBezique) doubleBezique = true;
        if (cards[i]->canMarry) marrage[cards[i]->getSuit()] = true;
        if (cards[i]->canFourKind)
            fourKind[cards[i]->getRank() - CONVERT_FLUSH_INDEX] = true;
    }
    score += bezique ? SCORE_BEZIQUE : 0;
    score += flush ? SCORE_FLUSH : 0;
    score += doubleBezique ? SCORE_DOUBLE_BEZIQUE : 0;
    for ( int i=0 ; i < Card::Suit::NumSuits ; i++ )
        if ( marrage[i])
            score += i == trumps ? SCORE_ROYAL_MARRAGE : SCORE_MARRAGE;
    for ( int j=0 ; j < 5 ; j++ )
    {
        if (fourKind[j])
        {
            switch (j) {
            case 0:
                score += SCORE_FOUR_JACKS;
                break;
            case 1:
                score += SCORE_FOUR_QUEENS;
                break;
            case 2:
                score += SCORE_FOUR_KINGS;
                break;
            case 4:
                score += SCORE_FOUR_ACES;
                break;
            default:
                break;
            }
        }
    }

    return score;
}

int BeziqueHand::countTensAces() const
{
    int count = 0;
    for ( int i=0 ; i<cards.size() ; i++ )
    {
        if ( cards[i]->getRank() == Card::Rank::Ten
             || cards[i]->getRank() == Card::Rank::Ace)
            count++;
    }
    return count;
}

int BeziqueHand::count(Card::Rank rank, Card::Suit suit) const
{
    int count = 0;
    for ( int i=0 ; i<cards.size() ; i++ )
    {
        if ( cards[i]->getRank() == rank
             && cards[i]->getSuit() == suit)
            count++;
    }
    return count;
}

int BeziqueHand::countRank(Card::Rank rank) const
{
    int count = 0;
    for ( int i=0 ; i<cards.size() ; i++ )
    {
        if ( cards[i]->getRank() == rank )
            count++;
    }
    return count;
}

int BeziqueHand::countMelded() const
{
    int count = 0;
    for ( int i=0 ; i< meldedCards.size() ; i++ )
    {
        if ( indexMelded(i) )
            count++;
    }
    return count;
}

int BeziqueHand::indexMelded(int index) const
{
    return meldedCards[index]->link == NOT_FOUND;
}

const QList<Card *> BeziqueHand::meldedCardList() const
{
    QList<Card *> melds;
    for ( int i=0 ; i< meldedCards.size() ; i++ )
    {
        if ( indexMelded(i) )
            melds.append(meldedCards[i]);
    }
    return melds;
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

const QList<Card*> BeziqueHand::cardList() const
{
    return cards;
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
























































