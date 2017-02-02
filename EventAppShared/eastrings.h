#ifndef EASTRINGS_H
#define EASTRINGS_H

#include <QQuickItem>
#include <QJsonObject>

class EAStrings : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString tbLoggedOff READ tbLoggedOff WRITE setTbLoggedOff NOTIFY tbLoggedOffChanged)

    Q_PROPERTY(QString mLogin READ mLogin WRITE setMLogin NOTIFY mLoginChanged)
    Q_PROPERTY(QString mLoadFKey READ mLoadFKey WRITE setMLoadFKey NOTIFY mLoadFKeyChanged)
    Q_PROPERTY(QString mLoadFFile READ mLoadFFile WRITE setMnLoadFFile NOTIFY mLoadFFileChanged)
    Q_PROPERTY(QString mLoadFFirebase READ mLoadFFirebase WRITE setMLoadFFirebase NOTIFY mLoadFFirebaseChanged)
    Q_PROPERTY(QString mAbout READ mAbout WRITE setMAbout NOTIFY mAboutChanged)
    Q_PROPERTY(QString mExit READ mExit WRITE setMExit NOTIFY mExitChanged)

    Q_PROPERTY(QString lUserId READ lUserId WRITE setLUserId NOTIFY lUserIdChanged)
    Q_PROPERTY(QString lPassword READ lPassword WRITE setLPassword NOTIFY lPasswordChanged)

    Q_PROPERTY(QString lkDownlaodFKey READ lkDownlaodFKey WRITE setLkDownlaodFKey NOTIFY lkDownlaodFKeyChanged)
    Q_PROPERTY(QString lfDownloadUrl READ lfDownloadUrl WRITE setLfDownloadUrl NOTIFY lfDownloadUrlChanged)
    Q_PROPERTY(QString lfFirebaseUrl READ lfFirebaseUrl WRITE setLfFirebaseUrl NOTIFY lfFirebaseUrlChanged)

    Q_PROPERTY(QString aboutText READ aboutText WRITE setAboutText NOTIFY aboutTextChanged)

    Q_PROPERTY(QString bRegister READ bRegister WRITE setBRegister NOTIFY bRegisterChanged)
    Q_PROPERTY(QString bLogin READ bLogin WRITE setBLogin NOTIFY bLoginChanged)
    Q_PROPERTY(QString bExit READ bExit WRITE setBExit NOTIFY bExitChanged)
    Q_PROPERTY(QString bLogoff READ bLogoff WRITE setBLogoff NOTIFY bLogoffChanged)
    Q_PROPERTY(QString bDownlaod READ bDownlaod WRITE setBDownlaod NOTIFY bDownlaodChanged)

    QString m_tbLoggedOff = "Logged off";
    QString m_mLogin = "Login";
    QString m_mLoadFKey = "Load from key";
    QString m_mLoadFFile = "Load from file";
    QString m_mLoadFFirebase = "Load from firebase";
    QString m_mAbout = "About";
    QString m_mExit = "Exit";
    QString m_lUserId = "User id";
    QString m_lPassword = "Password";
    QString m_lkDownlaodFKey = "Download key";
    QString m_lfDownloadUrl = "Download url";
    QString m_lfFirebaseUrl = "Firebase url";
    QString m_bRegister = "Register";
    QString m_bLogin = "Login";
    QString m_bExit = "Exit";
    QString m_bLogoff = "Logoff";
    QString m_bDownlaod = "Downlaod";    
    QString m_aboutText;

public:
    EAStrings();

    void read(const QJsonObject &json);
    void write(QJsonObject &json);

    QString tbLoggedOff() const
    {
        return m_tbLoggedOff;
    }

    QString mLogin() const
    {
        return m_mLogin;
    }

    QString mLoadFKey() const
    {
        return m_mLoadFKey;
    }

    QString mLoadFFile() const
    {
        return m_mLoadFFile;
    }

    QString mLoadFFirebase() const
    {
        return m_mLoadFFirebase;
    }

    QString mAbout() const
    {
        return m_mAbout;
    }

    QString mExit() const
    {
        return m_mExit;
    }

    QString lUserId() const
    {
        return m_lUserId;
    }

    QString lPassword() const
    {
        return m_lPassword;
    }

    QString lkDownlaodFKey() const
    {
        return m_lkDownlaodFKey;
    }

    QString lfDownloadUrl() const
    {
        return m_lfDownloadUrl;
    }

    QString lfFirebaseUrl() const
    {
        return m_lfFirebaseUrl;
    }

    QString bRegister() const
    {
        return m_bRegister;
    }

    QString bLogin() const
    {
        return m_bLogin;
    }

    QString bExit() const
    {
        return m_bExit;
    }

    QString bLogoff() const
    {
        return m_bLogoff;
    }

    QString bDownlaod() const
    {
        return m_bDownlaod;
    }

    QString aboutText() const
    {
        return m_aboutText;
    }

signals:

    void tbLoggedOffChanged(QString tbLoggedOff);

    void mLoginChanged(QString mLogin);

    void mLoadFKeyChanged(QString mLoadFKey);

    void mLoadFFileChanged(QString mLoadFFile);

    void mLoadFFirebaseChanged(QString mLoadFFirebase);

    void mAboutChanged(QString mAbout);

    void mExitChanged(QString mExit);

    void lUserIdChanged(QString lUserId);

    void lPasswordChanged(QString lPassword);

    void lkDownlaodFKeyChanged(QString lkDownlaodFKey);

    void lfDownloadUrlChanged(QString lfDownloadUrl);

    void lfFirebaseUrlChanged(QString lfFirebaseUrl);

    void bRegisterChanged(QString bRegister);

    void bLoginChanged(QString bLogin);

    void bExitChanged(QString bExit);

    void bLogoffChanged(QString bLogoff);

    void bDownlaodChanged(QString bDownlaod);

    void aboutTextChanged(QString aboutText);

public slots:
void setTbLoggedOff(QString tbLoggedOff)
{
    if (m_tbLoggedOff == tbLoggedOff)
        return;

    m_tbLoggedOff = tbLoggedOff;
    emit tbLoggedOffChanged(tbLoggedOff);
}
void setMLogin(QString mLogin)
{
    if (m_mLogin == mLogin)
        return;

    m_mLogin = mLogin;
    emit mLoginChanged(mLogin);
}
void setMLoadFKey(QString mLoadFKey)
{
    if (m_mLoadFKey == mLoadFKey)
        return;

    m_mLoadFKey = mLoadFKey;
    emit mLoadFKeyChanged(mLoadFKey);
}
void setMnLoadFFile(QString mLoadFFile)
{
    if (m_mLoadFFile == mLoadFFile)
        return;

    m_mLoadFFile = mLoadFFile;
    emit mLoadFFileChanged(mLoadFFile);
}
void setMLoadFFirebase(QString mLoadFFirebase)
{
    if (m_mLoadFFirebase == mLoadFFirebase)
        return;

    m_mLoadFFirebase = mLoadFFirebase;
    emit mLoadFFirebaseChanged(mLoadFFirebase);
}
void setMAbout(QString mAbout)
{
    if (m_mAbout == mAbout)
        return;

    m_mAbout = mAbout;
    emit mAboutChanged(mAbout);
}
void setMExit(QString mExit)
{
    if (m_mExit == mExit)
        return;

    m_mExit = mExit;
    emit mExitChanged(mExit);
}
void setLUserId(QString lUserId)
{
    if (m_lUserId == lUserId)
        return;

    m_lUserId = lUserId;
    emit lUserIdChanged(lUserId);
}
void setLPassword(QString lPassword)
{
    if (m_lPassword == lPassword)
        return;

    m_lPassword = lPassword;
    emit lPasswordChanged(lPassword);
}
void setLkDownlaodFKey(QString lkDownlaodFKey)
{
    if (m_lkDownlaodFKey == lkDownlaodFKey)
        return;

    m_lkDownlaodFKey = lkDownlaodFKey;
    emit lkDownlaodFKeyChanged(lkDownlaodFKey);
}
void setLfDownloadUrl(QString lfDownloadUrl)
{
    if (m_lfDownloadUrl == lfDownloadUrl)
        return;

    m_lfDownloadUrl = lfDownloadUrl;
    emit lfDownloadUrlChanged(lfDownloadUrl);
}
void setLfFirebaseUrl(QString lfFirebaseUrl)
{
    if (m_lfFirebaseUrl == lfFirebaseUrl)
        return;

    m_lfFirebaseUrl = lfFirebaseUrl;
    emit lfFirebaseUrlChanged(lfFirebaseUrl);
}
void setBRegister(QString bRegister)
{
    if (m_bRegister == bRegister)
        return;

    m_bRegister = bRegister;
    emit bRegisterChanged(bRegister);
}
void setBLogin(QString bLogin)
{
    if (m_bLogin == bLogin)
        return;

    m_bLogin = bLogin;
    emit bLoginChanged(bLogin);
}
void setBExit(QString bExit)
{
    if (m_bExit == bExit)
        return;

    m_bExit = bExit;
    emit bExitChanged(bExit);
}
void setBLogoff(QString bLogoff)
{
    if (m_bLogoff == bLogoff)
        return;

    m_bLogoff = bLogoff;
    emit bLogoffChanged(bLogoff);
}
void setBDownlaod(QString bDownlaod)
{
    if (m_bDownlaod == bDownlaod)
        return;

    m_bDownlaod = bDownlaod;
    emit bDownlaodChanged(bDownlaod);
}
void setAboutText(QString aboutText)
{
    if (m_aboutText == aboutText)
        return;

    m_aboutText = aboutText;
    emit aboutTextChanged(aboutText);
}
};

#endif // EASTRINGS_H
