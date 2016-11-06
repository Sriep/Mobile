#ifndef CARD_H
#define CARD_H
#include <QQuickItem>

class Card : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString image READ getImage WRITE setImage NOTIFY cardChanged)
    Q_PROPERTY(int rank READ getRank WRITE setRank NOTIFY cardChanged)
    Q_PROPERTY(int suit READ getSuit WRITE setSuit NOTIFY cardChanged)

    Q_PROPERTY(bool canMeld READ getCanMeld WRITE setCanMeld NOTIFY canMeldChanged)
public:
    //Q_INVOKABLE void cardPlayed(int index, int x, int y);
    friend class BeziqueHand;

    enum Rank { Seven = 0, Eight, Nine, Jack, Queen, King, Ten, Ace, NumRanks };
    enum Suit { Diamonds = 0, Clubs, Hearts, Spades, NumSuits };
    static const int EMPTY = 8;

    const QString rankStr[8]  {"07", "08", "09", "11", "12", "13", "10", "01"};
    const QString suitStr[4]  {"d", "c", "h", "s"};
    const QString emptyBitmap = "content/gfx/onePixelGreen.png";
    const QString backBitmap = "content/gfx/tinydeck/back111.gif";
    const int maxId = 63;

    Card();
    explicit Card(int iCard, QQuickItem *parent = 0);
    explicit Card(const Card* card, QQuickItem *parent = 0);
    Card(const Card& card, QQuickItem *parent = 0);

    bool beats(const Card& c, int trumps) const;

    void setCard(int cardId, int newLink = EMPTY);
    void copyCard(const Card& card);
    int getCardId() const;
    void clearCard();
    bool isCleard();

    // qml Properties access
    int getRank() const;
    int getSuit() const;
    void setRank(int value);
    void setSuit(int value);
    QString getImage() const;
    void setImage(QString image);
    bool getCanMeld() const;
    void setCanMeld(bool value);

    int getLink() const;
    void setLink(int value);

signals:
    void cardChanged();
    void canMeldChanged();
public slots:
private:
    QString getFilename(int rank, int suit);
    void clearMeldStatus();

    // qml Properties
    int rank;
    int suit;
    QString imageFile = emptyBitmap;

    int link = EMPTY;
    int cardId;

    bool canMeld = false;
    bool hasMarried = false;
    bool hasBeziqued = false;
    bool hasFlushed = false;
    bool hasFourKinded = false;

    bool canSeven = false;
    bool canMarry = false;
    bool canFlush = false;
    bool canBezique = false;
    bool canDoubleBezique = false;
    bool canFourKind = false;
};

#endif // CARD_H














































