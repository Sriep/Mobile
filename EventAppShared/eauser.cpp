#include <QUrl>
#include <QUrlQuery>
#include "eauser.h"
#include "eacontainer.h"
#include "firebase.h"

EAUser::EAUser()
{

}

EAUser::EAUser(EAContainer *eaContainer)
    : eaContainer(eaContainer)
{

}

bool EAUser::registerUser(const QString& userId
                          , const QString& email
                          , const QString& password)
{
    if (getEaContainer()->isEventStatic())
    {
        emit getEaContainer()->error(tr("Error registering user")
                    ,tr("Event does not support users")
                    ,"EAUser::registerUser\nisEventStatic==true"
                    , Warning);
        return false;
    }

    if (!isUserEmailTaken(email))
    {
        QJsonObject jsonUserData;
        jsonUserData["password"] = password.trimmed();
        jsonUserData["email"] = email.trimmed();

        QString userIdTrimmed = userId.trimmed();
        QJsonObject jsonUser;
        jsonUser[userIdTrimmed] = jsonUserData;
        setEmail(email);

        QJsonDocument userDoc(jsonUser);
        Firebase *firebase = new Firebase(getEaContainer()->firbaseUrl()
                                          , getEaContainer()->eventKey());
        Firebase* fbUsers = firebase->child("users");
        fbUsers->setValue(userDoc, "PATCH");
        setLoggedOn(true);

        //addIndex("users", "password");
        return true;
    }
    else
        return false;
}
/*
void EAUser::addIndex(const QString &table, const QString &field)
{
    QJsonArray indexArray = {
        "eamil",
        "password"
    };
    QJsonObject rulesObj;
    rulesObj[".indexOn"] = indexArray;
    QJsonDocument ruleDoc(rulesObj);

    Firebase *firebase = new Firebase(getEaContainer()->firbaseUrl()
                                      , getEaContainer()->eventKey());
    Firebase* fbUsers = firebase->child("users");
    fbUsers->setValue(ruleDoc, "PUT", "rules");
}
*/
bool EAUser::login(const QString &userId, const QString &password)
{
    if (getEaContainer()->isEventStatic())
    {
        emit getEaContainer()->error(tr("Error loging on")
                    ,tr("Event does not support users")
                    ,"EAUser::login\nisEventStatic==true"
                    , Warning);
        return false;
    }

    tempPassword = password;
    tempUser = userId;
    Firebase *firebase = new Firebase(getEaContainer()->firbaseUrl()
                                      , getEaContainer()->eventKey());
    QString path;
    //path = "users/" + userId + "/" + password;
    path = "users/" + userId;
    Firebase *fbUsers = firebase->child(path);

    //QUrl queryUrl(fbUsers->getPath());
    //QUrlQuery query;
    //QString qPasswordQ = "\"password\"";
    //QString qvalueQ = "\"value\"";
    //QString qThePasswordQ = "\"" + password + "\"";
    //query.addQueryItem("orderBy", qPasswordQ);
    //query.addQueryItem("equalTo",  qThePasswordQ);
    // queryUrl.setQuery(query);
    //"{\n  \"error\" : \"Index not defined, add \\\".indexOn\\\": \\\"value\\\", "
    //"for path \\\"/4455/users/myemail/password\\\", to the rules\"\n}\n"
    //fbUsers->getValue(queryUrl);

    fbUsers->getValue();
    connect(fbUsers,SIGNAL(eventResponseReady(QByteArray)),
            this,SLOT(onResponseReady(QByteArray)));
    connect(fbUsers,SIGNAL(eventDataChanged(QString*)),
            this,SLOT(onDataChanged(QString*)));
    return false;
}

void EAUser::onResponseReady(QByteArray data)
{
    qDebug()<<"answer";
    qDebug()<<data;

    QJsonDocument loadDoc = QJsonDocument::fromJson(data);
    QJsonObject userObj = loadDoc.object();
    if (userObj.count() > 0)
    {
        //QString user = userObj.keys()[0];
        //QJsonObject::const_iterator firstIt = userObj.begin();
        //QJsonObject userData = (*firstIt).toObject();
        QString password = userObj["password"].toString();
        QString email = userObj["email"].toString();
        if (password == tempPassword)
        {
            setUser(tempUser);
            setEmail(email);
            setLoggedOn(true);
            //emit loggedOnChanged(true);
            emit userPasswordAccepted(true);
        }
        else
            emit userPasswordAccepted(false);
    }
    else
        emit userPasswordAccepted(false);
    tempPassword = ""; tempUser = "";

    qDebug() << "EAContainer::downloadEventApp finished";
}

void EAUser::onDataChanged(QString data)
{
    qDebug()<<data;
}

void EAUser::logoff()
{
    setUser("");
    setEmail("");
    setLoggedOn(false);
}

bool EAUser::isUserEmailTaken(const QString email)
{
    return false;
}


QString EAUser::user() const
{
    return m_user;
}

int EAUser::index() const
{
    return m_index;
}

QString EAUser::email() const
{
    return m_email;
}

void EAUser::setUser(QString user)
{
    if (m_user == user)
        return;

    m_user = user;
    emit userChanged(user);
}

void EAUser::setIndex(int index)
{
    if (m_index == index)
        return;

    m_index = index;
    emit indexChanged(index);
}

void EAUser::setEmail(QString email)
{
    if (m_email == email)
        return;

    m_email = email;
    emit emailChanged(email);
}

void EAUser::setLoggedOn(bool loggedOn)
{
    if (m_loggedOn == loggedOn)
        return;

    m_loggedOn = loggedOn;
    emit loggedOnChanged(loggedOn);
}

EAContainer *EAUser::getEaContainer() const
{
    return eaContainer;
}

void EAUser::setEaContainer(EAContainer *value)
{
    eaContainer = value;
}

bool EAUser::loggedOn() const
{
    return m_loggedOn;
}
