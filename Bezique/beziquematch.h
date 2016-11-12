#ifndef BEZIQUEMATCH_H
#define BEZIQUEMATCH_H

#include <QQuickItem>

#include "gamedata.h"

enum SaveFormat {Json, Binary };
class BeziqueMatch : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(GameData* gameData READ getGameData WRITE setGameData NOTIFY gameDataChanged)
    Q_PROPERTY(QString bottomName READ getBottomName WRITE setBottomName NOTIFY bottomNameChanged)
    Q_PROPERTY(QString topName READ getTopName WRITE setTopName NOTIFY topNameChanged)
    Q_PROPERTY(int bottomGamesWon READ getBottomGamesWon WRITE setBottomGamesWon NOTIFY bottomGamesWonChanged)
    Q_PROPERTY(int topGamesWon READ getTopGamesWon WRITE setTopGamesWon NOTIFY topGamesWonChanged)

public:
    BeziqueMatch();
    bool loadMatch(SaveFormat saveFormat = Json);
    bool saveMatch(SaveFormat saveFormat = Json) const;

    QString getBottomName() const;
    void setBottomName(const QString &value);
    QString getTopName() const;
    void setTopName(const QString &value);
    int getBottomGamesWon() const;
    void setBottomGamesWon(int value);
    int getTopGamesWon() const;
    void setTopGamesWon(int value);

    GameData *getGameData() const;
    void setGameData(GameData *value);

    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;
signals:
    void gameDataChanged();
    void bottomNameChanged();
    void topNameChanged();
    void bottomGamesWonChanged();
    void topGamesWonChanged();
public slots:
    void gameFinished(int topScore, int bottomScore);
    void trickOver();
private:

    GameData* gameData;
    QString bottomName = "human";
    QString topName = "top";
    int bottomGamesWon = 0;
    int topGamesWon = 0;
};

#endif // BEZIQUEMATCH_H


