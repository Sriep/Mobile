#ifndef HTTPDOWNLOAD_H
#define HTTPDOWNLOAD_H

#include <QQuickItem>
#include <QUrl>
#include <QNetworkAccessManager>
#include <QString>

#include "eventappshared_global.h"

QT_BEGIN_NAMESPACE
class QFile;
//class QSslError;
class QAuthenticator;
class QNetworkReply;
QT_END_NAMESPACE

class  HttpDownload : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QUrl url READ url WRITE setUrl NOTIFY urlChanged)
    Q_PROPERTY(QString user READ user WRITE setUser NOTIFY userChanged)
    Q_PROPERTY(QString password READ password WRITE setPassword NOTIFY passwordChanged)
    Q_PROPERTY(QString fileDownloaded READ fileDownloaded WRITE setFileDownloaded NOTIFY fileDownloadedChanged)

public:
    HttpDownload();
    Q_INVOKABLE QString downloadFile(QUrl url);

    QUrl url() const;
    QString user() const;
    QString password() const;

    QString fileDownloaded() const;

signals:
    void urlChanged(QUrl url);
    void downloadProgress(qint64 bytesReceived, qint64 bytesTotal);
    void finished();
    void finishedDownload();
    void error(QString message);
    void authenticationRequired();
    void userChanged(QString user);
    void passwordChanged(QString password);

    void fileDownloadedChanged(QString fileDownloaded);

public slots:
    void setUrl(QUrl url);
    void setUser(QString user);
    void setPassword(QString password);

    void setFileDownloaded(QString fileDownloaded);

private slots:
    void slotAuthenticationRequired(QNetworkReply*,QAuthenticator *authenticator);
    void httpFinished();
    void httpReadyRead();

private:
    void startRequest();
    void preProcessUrl();
    QFile *openFileForWrite(const QString &fileName);

    QNetworkAccessManager qnam;
    QNetworkReply *reply;

    QString defaultFileName  = "data.json";
    QFile *file;
    bool httpRequestAborted;

    QUrl m_url;
    QString m_user;
    QString m_password;
    QString m_fileDownloaded;
};



#endif // HTTPDOWNLOAD_H
