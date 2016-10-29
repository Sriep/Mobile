#include "gamedata.h"
#include "game.h"

GameData::GameData(QQuickItem *parent)
    : QQuickItem(parent)
{

}

Card *GameData::getFaceCard() const
{
    return faceCard;
}

void GameData::setFaceCard(Card *value)
{
    faceCard = value;
}

void GameData::startNewGame()
{
    Game game(this);
    game.start();
}
