#ifndef CONTROLEDPLAYER_H
#define CONTROLEDPLAYER_H
#include "player.h"

class ControledPlayer : public Player
{
public:
    ControledPlayer(Game& game, QQuickItem *parent = 0);
};

#endif // CONTROLEDPLAYER_H
