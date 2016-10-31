#ifndef AIPLAYER_H
#define AIPLAYER_H

#include "player.h"

class AiPlayer : public Player
{
public:
    AiPlayer();//QQuickItem *parent = 0);
    virtual bool isControlled() const;
    virtual ~AiPlayer() {}
private:
    void init();
};

#endif // AIPLAYER_H
