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

QString EAStrings::copyClipbord() const
{
    return m_copyClipbord;
}

void EAStrings::setTbLoggedOff(QString tbLoggedOff)
{
    if (m_tbLoggedOff == tbLoggedOff)
        return;

    m_tbLoggedOff = tbLoggedOff;
    emit tbLoggedOffChanged(tbLoggedOff);
}

void EAStrings::setMLogin(QString mLogin)
{
    if (m_mLogin == mLogin)
        return;

    m_mLogin = mLogin;
    emit mLoginChanged(mLogin);
}

void EAStrings::setMLoadFKey(QString mLoadFKey)
{
    if (m_mLoadFKey == mLoadFKey)
        return;

    m_mLoadFKey = mLoadFKey;
    emit mLoadFKeyChanged(mLoadFKey);
}

void EAStrings::setMnLoadFFile(QString mLoadFFile)
{
    if (m_mLoadFFile == mLoadFFile)
        return;

    m_mLoadFFile = mLoadFFile;
    emit mLoadFFileChanged(mLoadFFile);
}

void EAStrings::setMLoadFFirebase(QString mLoadFFirebase)
{
    if (m_mLoadFFirebase == mLoadFFirebase)
        return;

    m_mLoadFFirebase = mLoadFFirebase;
    emit mLoadFFirebaseChanged(mLoadFFirebase);
}

void EAStrings::setMAbout(QString mAbout)
{
    if (m_mAbout == mAbout)
        return;

    m_mAbout = mAbout;
    emit mAboutChanged(mAbout);
}

void EAStrings::setMExit(QString mExit)
{
    if (m_mExit == mExit)
        return;

    m_mExit = mExit;
    emit mExitChanged(mExit);
}

void EAStrings::setLUserId(QString lUserId)
{
    if (m_lUserId == lUserId)
        return;

    m_lUserId = lUserId;
    emit lUserIdChanged(lUserId);
}

void EAStrings::setLPassword(QString lPassword)
{
    if (m_lPassword == lPassword)
        return;

    m_lPassword = lPassword;
    emit lPasswordChanged(lPassword);
}

void EAStrings::setLkDownlaodFKey(QString lkDownlaodFKey)
{
    if (m_lkDownlaodFKey == lkDownlaodFKey)
        return;

    m_lkDownlaodFKey = lkDownlaodFKey;
    emit lkDownlaodFKeyChanged(lkDownlaodFKey);
}

void EAStrings::setLfDownloadUrl(QString lfDownloadUrl)
{
    if (m_lfDownloadUrl == lfDownloadUrl)
        return;

    m_lfDownloadUrl = lfDownloadUrl;
    emit lfDownloadUrlChanged(lfDownloadUrl);
}

void EAStrings::setLfFirebaseUrl(QString lfFirebaseUrl)
{
    if (m_lfFirebaseUrl == lfFirebaseUrl)
        return;

    m_lfFirebaseUrl = lfFirebaseUrl;
    emit lfFirebaseUrlChanged(lfFirebaseUrl);
}

void EAStrings::setBRegister(QString bRegister)
{
    if (m_bRegister == bRegister)
        return;

    m_bRegister = bRegister;
    emit bRegisterChanged(bRegister);
}

void EAStrings::setBLogin(QString bLogin)
{
    if (m_bLogin == bLogin)
        return;

    m_bLogin = bLogin;
    emit bLoginChanged(bLogin);
}

void EAStrings::setBExit(QString bExit)
{
    if (m_bExit == bExit)
        return;

    m_bExit = bExit;
    emit bExitChanged(bExit);
}

void EAStrings::setBLogoff(QString bLogoff)
{
    if (m_bLogoff == bLogoff)
        return;

    m_bLogoff = bLogoff;
    emit bLogoffChanged(bLogoff);
}

void EAStrings::setBDownlaod(QString bDownlaod)
{
    if (m_bDownlaod == bDownlaod)
        return;

    m_bDownlaod = bDownlaod;
    emit bDownlaodChanged(bDownlaod);
}

void EAStrings::setAboutText(QString aboutText)
{
    if (m_aboutText == aboutText)
        return;

    m_aboutText = aboutText;
    emit aboutTextChanged(aboutText);
}

void EAStrings::setCopyClipbord(QString copyClipbord)
{
    if (m_copyClipbord == copyClipbord)
        return;

    m_copyClipbord = copyClipbord;
    emit copyClipbordChanged(copyClipbord);
}
