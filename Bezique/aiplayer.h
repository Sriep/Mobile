#ifndef AIPLAYER_H
#define AIPLAYER_H

#include "player.h"

class AiPlayer : public Player
{
public:
    AiPlayer( QQuickItem *parent = 0);
    virtual bool isControlled() {return false;}
    virtual ~AiPlayer() {}
};

#endif // AIPLAYER_H
