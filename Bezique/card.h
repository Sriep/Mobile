#ifndef CARD_H
#define CARD_H


struct Card
{
    enum Rank { Seven = 0, Eight, Nine, Jack, Queen, King, Ten, Ace };
    enum Suit { Clubs = 0, Diamonds, Hearts, Spades };

    int rank;
    int suit;

    Card(int rank, int suit);
    Card(int iCard);
    Card(const Card& c);
    Card();
    ~Card();
    bool beats(const Card& c, int trumps);
    static Card intToCard(int intCard);
};

#endif // CARD_H
