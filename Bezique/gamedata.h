#ifndef GAMEDATA_H
#define GAMEDATA_H

#include <QQuickItem>
#include "card.h"
#include "gamestate.h"
#include "gamestate.h"

class GameData : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(Card upCard READ getFaceCard )
public:
    friend class GameState;
    GameData(QQuickItem *parent = 0);

    Card *getFaceCard() const;

    Q_INVOKABLE void startNewGame();
    Q_INVOKABLE void cardPlayed(int index);
signals:
    void deckCut();
    void handsDealt();
    void trickFinished();
    void startEndgame();
    void handOver();
    void gameOver();
    void leadCardPlayed();
    void followedToTrick();
    void faceCardChanged();
    void waitingForCard();
    void waitingForMeld();
    void melded();
private slots:
    void cutForDeal();
    void dealCards();
    void leadToTrick();
    void followToTrick();
    void playEndTrick();
    void meld();
private:
    void setFaceCard(Card *value);
    void switchActivePlayer();

    int startPlayer;
    Card* faceCard;
    Player* player1;
    Player* player2;
    Player* activePlayer;
    Card* firstCard;
    Card* secondCard;
    bool isPlayFirstCard = false;
    int trumps;
    BeziqueDeck deck;
    GameState game;
};

#endif // GAMEDATA_H
