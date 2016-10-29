#ifndef GAMEDATA_H
#define GAMEDATA_H

#include <QQuickItem>
#include "card.h"

class GameData : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(Card upCard READ getFaceCard )
public:
    GameData(QQuickItem *parent = 0);

    Card *getFaceCard() const;
    void setFaceCard(Card *value);

    Q_INVOKABLE void startNewGame();
signals:
    void faceCardChanged();
public slots:
private:
    Card* faceCard;
    //Player* player1;
    //Player* player2;
    //BeziqueDeck deck;
};

#endif // GAMEDATA_H
