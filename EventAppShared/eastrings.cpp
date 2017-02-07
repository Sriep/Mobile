#include "eastrings.h"


EAStrings::EAStrings()
{

}

void EAStrings::emitStringChangedSignal()
{
    emit stringsChanged();
}

void EAStrings::read(const QJsonObject &json)
{
    setTbLoggedOff(json["tbLoggedOff"].toString());

    setMLogin(json["mLogin"].toString());
    setMLoadFKey(json["mLoadFKey"].toString());
    setMnLoadFFile(json["mLoadFFile"].toString());
    setMLoadFFirebase(json["mLoadFFirebase"].toString());
    setMAbout(json["mAbout"].toString());
    setMExit(json["mExit"].toString());

    setLUserId(json["lUserId"].toString());
    setLPassword(json["lPassword"].toString());

    setLkDownlaodFKey(json["lkDownlaodFKey"].toString());
    setLfDownloadUrl(json["lfDownloadUrl"].toString());
    setLfFirebaseUrl(json["lfFirebaseUrl"].toString());

    setAboutText(json["aboutText"].toString());

    setBRegister(json["bRegister"].toString());
    setBLogin(json["bLogin"].toString());
    setBExit(json["bExit"].toString());
    setBLogoff(json["bLogoff"].toString());
    setBDownlaod(json["bDownlaod"].toString());
}

void EAStrings::write(QJsonObject &json)
{
    json["tbLoggedOff"] = tbLoggedOff();

    json["mLogin"] = mLogin();
    json["mLoadFKey"] = mLoadFKey();
    json["mLoadFFile"] = mLoadFFile();
    json["mLoadFFirebase"] = mLoadFFirebase();
    json["mAbout"] = mAbout();
    json["mExit"] = mExit();

    json["lUserId"] = lUserId();
    json["lPassword"] = lPassword();

    json["lkDownlaodFKey"] = lkDownlaodFKey();
    json["lfDownloadUrl"] = lfDownloadUrl();
    json["lfFirebaseUrl"] = lfFirebaseUrl();

    json["aboutText"] = aboutText();

    json["bRegister"] = bRegister();
    json["bLogin"] = bLogin();
    json["bExit"] = bExit();
    json["bLogoff"] = bLogoff();
    json["bDownlaod"] = bDownlaod();
}

QString EAStrings::tbLoggedOff() const
{
    return m_tbLoggedOff;
}

QString EAStrings::mLogin() const
{
    return m_mLogin;
}

QString EAStrings::mLoadFKey() const
{
    return m_mLoadFKey;
}

QString EAStrings::mLoadFFile() const
{
    return m_mLoadFFile;
}

QString EAStrings::mLoadFFirebase() const
{
    return m_mLoadFFirebase;
}

QString EAStrings::mAbout() const
{
    return m_mAbout;
}

QString EAStrings::mExit() const
{
    return m_mExit;
}

QString EAStrings::lUserId() const
{
    return m_lUserId;
}

QString EAStrings::lPassword() const
{
    return m_lPassword;
}

QString EAStrings::lkDownlaodFKey() const
{
    return m_lkDownlaodFKey;
}

QString EAStrings::lfDownloadUrl() const
{
    return m_lfDownloadUrl;
}

QString EAStrings::lfFirebaseUrl() const
{
    return m_lfFirebaseUrl;
}

QString EAStrings::bRegister() const
{
    return m_bRegister;
}

QString EAStrings::bLogin() const
{
    return m_bLogin;
}

QString EAStrings::bExit() const
{
    return m_bExit;
}

QString EAStrings::bLogoff() const
{
    return m_bLogoff;
}

QString EAStrings::bDownlaod() const
{
    return m_bDownlaod;
}

QString EAStrings::aboutText() const
{
    return m_aboutText;
}
