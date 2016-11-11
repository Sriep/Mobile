#include "beziquematch.h"


BeziqueMatch::BeziqueMatch()
{    
}

QString BeziqueMatch::getPlayerName() const
{
    return playerName;
}

void BeziqueMatch::setPlayerName(const QString &value)
{
    if (playerName != value)
    {
        playerName = value;
        emit playerNameChanged();
    }
}

QString BeziqueMatch::getAiName() const
{
    return aiName;
}

void BeziqueMatch::setAiName(const QString &value)
{
    if (aiName != value)
    {
        aiName = value;
        emit aiNameChanged();
    }
}

int BeziqueMatch::getPlayerGamesWon() const
{
    return playerGamesWon;
}

void BeziqueMatch::setPlayerGamesWon(int value)
{
    if (playerGamesWon != value)
    {
        playerGamesWon = value;
        emit playerGamesWonChanged();
    }
}

int BeziqueMatch::getAiGamesWon() const
{
    return aiGamesWon;
}

void BeziqueMatch::setAiGamesWon(int value)
{
    if (aiGamesWon != value)
    {
        aiGamesWon = value;
        emit aiGamesWonChanged();
    }
}

GameData *BeziqueMatch::getGameData() const
{
    return gameData;
}

void BeziqueMatch::setGameData(GameData *value)
{
    if(gameData != value)
    {
        gameData = value;
        emit gameDataChanged();
    }
}












































