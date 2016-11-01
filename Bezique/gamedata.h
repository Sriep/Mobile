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
    Q_PROPERTY(Card* faceCard READ getFaceCard
               WRITE setFaceCard NOTIFY changedFaceCard)
   // Q_PROPERTY(int humansCardIndex READ getHumansCardIndex
   //            WRITE setHumansCardIndex NOTIFY changedHumansCardIndex)
   // Q_PROPERTY(int aisCardIndex READ getAisCardIndex
   //            WRITE setAisCardIndex NOTIFY changedAisCardIndex)
     Q_PROPERTY(Card* humansCard READ getHumansCard WRITE setHumansCard NOTIFY changedHumansCard)
     Q_PROPERTY(Card* aisCard READ getAisCard WRITE setAisCard NOTIFY changedAisCard)

    Q_PROPERTY(Player* humanPlayer READ getHumanPlayer WRITE setHumanPlayer)
    Q_PROPERTY(Player* aiPlayer READ getAiPlayer WRITE setAiPlayer)
public:
    friend class GameState;
    GameData(QQuickItem *parent = 0);

    Card *getFaceCard() const;
    void setFaceCard(Card *value);

    //BeziqueHand *playerHand() const;
    //BeziqueHand *aiHand() const;
    //void setPlayerHand(BeziqueHand* hand);
    //void setAiHand(BeziqueHand* hand);

    //QQmlListProperty<Card> getCards();

    Q_INVOKABLE void startNewGame();
    Q_INVOKABLE void cardPlayed(int index, bool melded = false);

    Player *getHumanPlayer() const;
    void setHumanPlayer(Player *value);
    Player *getAiPlayer() const;
    void setAiPlayer(Player *value);

    Card* getAisCard() const;
    void setAisCard(Card* value);
    Card* getHumansCard() const;
    void setHumansCard(Card* value);

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
    //void cardsChanged();
private slots:
    void cutForDeal();
    void dealCards();
    void leadToTrick();
    void followToTrick();
    void playEndTrick();
    void meld();
private:
    //static void appendCard(QQmlListProperty<Card> *list, Card *card);
    //void appendCard(QQmlListProperty<Card> *list, Card *card);

    void switchActivePlayer();
    void init();

    // qml properties
    Card* faceCard;
    Player* aiPlayer;
    Player* humanPlayer;
    Card* aisCard;
    Card* humansCard;

    int startPlayer;
    Player* activePlayer;
    bool isPlayFirstCard = false;
    int trumps;
    BeziqueDeck deck;
    GameState game;
};

#endif // GAMEDATA_H
