#ifndef CARD_H
#define CARD_H
#include <QQuickItem>

class Card : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString image READ getImage WRITE setImage NOTIFY imageChanged)
public:
    Q_INVOKABLE void cardPlayed(int index, int x, int y);

    enum Rank { Seven = 0, Eight, Nine, Jack, Queen, King, Ten, Ace };
    enum Suit { Diamonds = 0, Clubs, Hearts, Spades };
    const QString rankStr[8]  {"07", "08", "09", "10", "11", "12", "13", "01"};
    const QString suitStr[4]  {"d", "c", "h", "s"};

    Card(QQuickItem *parent = 0);
    Card(int iCard, QQuickItem *parent = 0);
    bool beats(const Card& c, int trumps);

    int getRank() const;
    int getSuit() const;

    QString getImage() const;
    void setImage(QString image);

signals:
    void imageChanged();
public slots:
private:
    QString getFilename(int rank, int suit);

    int rank;
    int suit;
    int cardId;
    QString imageFile;
};

#endif // CARD_H
