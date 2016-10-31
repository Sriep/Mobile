#ifndef CONTROLEDPLAYER_H
#define CONTROLEDPLAYER_H
#include "player.h"

class ControledPlayer : public Player
{
public:
    ControledPlayer();// QQuickItem *parent = 0);
    virtual bool isControlled() const;
    virtual ~ControledPlayer() {}
private:
    void init();
};

#endif // CONTROLEDPLAYER_H
