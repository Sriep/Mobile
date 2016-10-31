#ifndef CARD_H
#define CARD_H
#include <QQuickItem>

class Card : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString image READ getImage WRITE setImage NOTIFY cardChanged)
    Q_PROPERTY(int rank READ getRank WRITE setRank NOTIFY cardChanged)
    Q_PROPERTY(int suit READ getSuit WRITE setSuit NOTIFY cardChanged)
public:
    Q_INVOKABLE void cardPlayed(int index, int x, int y);

    enum Rank { Seven = 0, Eight, Nine, Jack, Queen, King, Ten, Ace, NumRanks };
    enum Suit { Diamonds = 0, Clubs, Hearts, Spades, NumSuits };
    const QString rankStr[8]  {"07", "08", "09", "10", "11", "12", "13", "01"};
    const QString suitStr[4]  {"d", "c", "h", "s"};
    const QString emptyBitmap = "content/gfx/onePixel.png";
    //const QString emptyBitmap = "content/gfx/back.png";
    const int maxId = 63;

    Card(QQuickItem *parent = 0);
    Card(int iCard, QQuickItem *parent = 0);
    Card(const Card& card, QQuickItem *parent = 0);

    //Card(QObject *parent = 0);
    //Card(int iCard, QObject *parent = 0);
    //Card(const Card& card, QObject *parent = 0);

    bool beats(const Card& c, int trumps);

    void setCard(int cardId);
    int getCardId() const;
    void clearCard();
    bool isCleard();

    // qml Properties
    int getRank() const;
    int getSuit() const;
    void setRank(int value);
    void setSuit(int value);
    QString getImage() const;
    void setImage(QString image);

signals:
    void cardChanged();
public slots:
private:
    QString getFilename(int rank, int suit);

    // qml Properties
    int rank;
    int suit;
    QString imageFile = emptyBitmap;

    int cardId;

};

#endif // CARD_H
