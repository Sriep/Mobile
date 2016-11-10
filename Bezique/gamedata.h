#ifndef GAMEDATA_H
#define GAMEDATA_H

#include <QQuickItem>
#include "card.h"
#include "gamestate.h"
#include "gamestate.h"
#include "beziquehand.h"

class GameData : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(Card* faceCard READ getFaceCard WRITE setFaceCard NOTIFY changedFaceCard)
    Q_PROPERTY(Card* humansCard READ getHumansCard WRITE setHumansCard NOTIFY changedHumansCard)
    Q_PROPERTY(Card* aisCard READ getAisCard WRITE setAisCard NOTIFY changedAisCard)

    Q_PROPERTY(Player* humanPlayer READ getHumanPlayer WRITE setHumanPlayer NOTIFY changedHumanPlayer)
    Q_PROPERTY(Player* aiPlayer READ getAiPlayer WRITE setAiPlayer NOTIFY changedAiPlayer)
    Q_PROPERTY(int trumps READ getTrumps WRITE setTrumps NOTIFY changedTrumps)
public:
    friend class GameState;
    GameData(QQuickItem *parent = 0);

    Card *getFaceCard() const;
    void setFaceCard(Card *value);

    static const int NO_MELD = -1;

    Q_INVOKABLE void startNewGame();
    Q_INVOKABLE void cardPlayed(int index, bool melded = false);
    Q_INVOKABLE void humanMeld(bool meldMade, int index = NO_MELD, bool meldRow = false);
    Q_INVOKABLE void finishTrick();

    Player *getHumanPlayer() const;
    void setHumanPlayer(Player *value);
    Player *getAiPlayer() const;
    void setAiPlayer(Player *value);
    void meldSeven();

    Card* getAisCard() const;
    void setAisCard(Card* value);
    Card* getHumansCard() const;
    void setHumansCard(Card* value);

    int getTrumps() const;

    bool getMeldedSeven() const;

    BeziqueDeck* getDeck();
    void setTrumps(int value);

public slots:
    Q_INVOKABLE void scoreEndTrick();
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
    void changedFaceCard();
    void changedHumansCard();
    void changedAisCard();
    void changedTrumps();
    void changedHumanPlayer();
    void changedAiPlayer();
    void playEndTrick();
    void drawing();
    //void cardsChanged();
private slots:
    void cutForDeal();
    void dealCards();
    void leadToTrick();
    void followToTrick();
    void meld();
    void endHand();
    void endGame();
private:
    void switchActivePlayer();
    void init();

    void ResetBoardForEndgame();

    // qml properties
    Card* faceCard = NULL;
    Player* aiPlayer = NULL;
    Player* humanPlayer = NULL;
    Card* aisCard = NULL;
    Card* humansCard = NULL;
    bool meldedSeven = false;

    int startPlayer;
    Player* activePlayer = NULL;
    bool isPlayFirstCard = false;
    int trumps;
    BeziqueDeck deck;
    GameState game;
    bool trickOver = false;
    bool isEndgame = false;
};

#endif // GAMEDATA_H
