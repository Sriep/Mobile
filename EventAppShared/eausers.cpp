#include "eausers.h"

EAUsers::EAUsers()
{

}

QString EAUsers::user() const
{
    return m_user;
}

int EAUsers::index() const
{
    return m_index;
}

void EAUsers::setUser(QString user)
{
    if (m_user == user)
        return;

    m_user = user;
    emit userChanged(user);
}

void EAUsers::setIndex(int index)
{
    if (m_index == index)
        return;

    m_index = index;
    emit indexChanged(index);
}
