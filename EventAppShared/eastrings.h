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
    Q_PROPERTY(QString copyClipbord READ copyClipbord WRITE setCopyClipbord NOTIFY copyClipbordChanged)

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
    QString m_aboutText = "About text\nAbout text\nAbout text\n";
    QString m_copyClipbord = "Copy from clipboard";

public:
    EAStrings();

    Q_INVOKABLE void emitStringChangedSignal();

    void read(const QJsonObject &json);
    void write(QJsonObject &json);

    QString tbLoggedOff() const;
    QString mLogin() const;
    QString mLoadFKey() const;
    QString mLoadFFile() const;
    QString mLoadFFirebase() const;
    QString mAbout() const;
    QString mExit() const;
    QString lUserId() const;
    QString lPassword() const;
    QString lkDownlaodFKey() const;
    QString lfDownloadUrl() const;
    QString lfFirebaseUrl() const;
    QString bRegister() const;
    QString bLogin() const;
    QString bExit() const;
    QString bLogoff() const;
    QString bDownlaod() const;
    QString aboutText() const;
    QString copyClipbord() const;

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
    void stringsChanged();
    void copyClipbordChanged(QString copyClipbord);

    public slots:
        void setTbLoggedOff(QString tbLoggedOff);
        void setMLogin(QString mLogin);
        void setMLoadFKey(QString mLoadFKey);
        void setMnLoadFFile(QString mLoadFFile);
        void setMLoadFFirebase(QString mLoadFFirebase);
        void setMAbout(QString mAbout);
        void setMExit(QString mExit);
        void setLUserId(QString lUserId);
        void setLPassword(QString lPassword);
        void setLkDownlaodFKey(QString lkDownlaodFKey);
        void setLfDownloadUrl(QString lfDownloadUrl);
        void setLfFirebaseUrl(QString lfFirebaseUrl);
        void setBRegister(QString bRegister);
        void setBLogin(QString bLogin);
        void setBExit(QString bExit);
        void setBLogoff(QString bLogoff);
        void setBDownlaod(QString bDownlaod);
        void setAboutText(QString aboutText);
        void setCopyClipbord(QString copyClipbord);
};

#endif // EASTRINGS_H
