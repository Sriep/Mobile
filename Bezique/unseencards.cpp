#include <QtDebug>

#include "unseencards.h"
#include "beziquehand.h"
#include "card.h"

UnseenCards::UnseenCards()
{
    reset();
}

void UnseenCards::reset()
{
    unseenCards.clear();
    for ( int i = 0 ; i < Card::NumRanks ; i++ )
    {
        QList<int> rank;
        for ( int j = 0 ; j < Card::NumSuits ; j++ )
        {
            rank.clear();
            rank << 2 << 2 << 2 << 2;
        }
        unseenCards.append(rank);
    }
    //Dump();
}

void UnseenCards::haveSeen(const Card &card)
{
    unseenCards[card.getRank()][card.getSuit()]--;
    //Dump();
}

void UnseenCards::haveSeen(int cardId)
{
        unseenCards[cardId / 8][cardId % 4]--;
        //Dump();
}

void UnseenCards::haveSeen(int rank, int suit)
{
    unseenCards[rank][suit]--;
    //Dump();
}

void UnseenCards::haveSeenHand(BeziqueHand *hand)
{
    for ( int i = 0 ; i < BeziqueHand::HAND_SIZE ; i++ )
    {
        haveSeen(*(hand->cardList().at(i)));
    }
    //Dump();
}

int UnseenCards::numUnseen(int rank, int suit) const
{
    return unseenCards[rank][suit];
}

int UnseenCards::numUnseenRank(int rank) const
{
    int count = 0;
    for ( int j = 0 ; j < Card::NumSuits ; j++ )
        count += unseenCards[rank][j];
    return count;
}

int UnseenCards::numUnseen() const
{
    int count;
    for ( int i = 0 ; i < Card::NumRanks ; i++ )
        for ( int j = 0 ; j < Card::NumSuits ; j++ )
            count += unseenCards[i][j];
    return count;
}

int UnseenCards::unseenThatBeat(Card *card, int trumps) const
{
    int count  = 0;
    for ( int i = card->getRank() + 1 ; i < Card::Rank::NumRanks ; i++ )
    {
        count += unseenCards[i][card->getSuit()];
    }
    if ( card->getSuit() != trumps )
    {
        for ( int i = 0 ; i < Card::Rank::NumRanks ; i++ )
        {
            count += unseenCards[i][trumps];
        }
    }
    return count;
}

void UnseenCards::Dump()
{
    qDebug() << "Unseen cards\n";
    for ( int i = 0 ; i < unseenCards.size() ; i++ )
    {

        qDebug() << i << "Diamands" << unseenCards[i][0] << " | "
                << i << "Clubs" << unseenCards[i][1] << " | "
                << i << "Hearts" << unseenCards[i][2] << " | "
                << i << "Spades" << unseenCards[i][3];
    }
    qDebug() << "Finished Unseen cards\n";
}


























