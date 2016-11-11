#ifndef BEZIQUEMATCH_H
#define BEZIQUEMATCH_H

#include <QQuickItem>

#include "gamedata.h"

class BeziqueMatch : public QQuickItem
{
    Q_OBJECT
    //Q_PROPERTY(GameData* gameData READ getGameData WRITE setGameData NOTIFY gameDataChanged)
    Q_PROPERTY(QString playerName READ getPlayerName WRITE setPlayerName NOTIFY playerNameChanged)
    Q_PROPERTY(QString aiName READ getAiName WRITE setAiName NOTIFY aiNameChanged)
    Q_PROPERTY(int playerGamesWon READ getPlayerGamesWon WRITE setPlayerGamesWon NOTIFY playerGamesWonChanged)
    Q_PROPERTY(int aiGamesWon READ getAiGamesWon WRITE setAiGamesWon NOTIFY aiGamesWonChanged)

public:
    BeziqueMatch();

    QString getPlayerName() const;
    void setPlayerName(const QString &value);
    QString getAiName() const;
    void setAiName(const QString &value);
    int getPlayerGamesWon() const;
    void setPlayerGamesWon(int value);
    int getAiGamesWon() const;
    void setAiGamesWon(int value);

    GameData *getGameData() const;
    void setGameData(GameData *value);

signals:
    void gameDataChanged();
    void playerNameChanged();
    void aiNameChanged();
    void playerGamesWonChanged();
    void aiGamesWonChanged();
public slots:

private:

    GameData* gameData;
    QString playerName = "human";
    QString aiName = "ai";
    int playerGamesWon = 0;
    int aiGamesWon = 0;
};

#endif // BEZIQUEMATCH_H


