#ifndef AIPLAYER_H
#define AIPLAYER_H

#include "player.h"

class AiPlayer : public Player
{
public:
    AiPlayer(Game& game, QQuickItem *parent = 0);
};

#endif // AIPLAYER_H
