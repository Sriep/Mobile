#include <QNetworkReply>
#include <QAuthenticator>
#include <QNetworkRequest>
#include <QIODevice>
#include <QUrlQuery>
#include <QFile>
#include <QDir>

#include "httpdownload.h"

HttpDownload::HttpDownload()
    : httpRequestAborted(false)
{
    connect(&qnam, &QNetworkAccessManager::authenticationRequired,
            this, &HttpDownload::slotAuthenticationRequired);
}

QString HttpDownload::downloadFile(QUrl url)
{
    m_url = url;
    //const QString urlSpec = urlLineEdit->text().trimmed();
    if (m_url.isEmpty())
    {
        emit error(tr("Empty url"));
        return "";
    }

    preProcessUrl();
    if (!m_url.isValid())
    {
        emit error(tr("Invalid url"));
        return "";
    }

    QString fileName = m_url.fileName();
    if (fileName.isEmpty())
        fileName = defaultFileName;
    if (QFile::exists(fileName))
        QFile::remove(fileName);

    file = openFileForWrite(fileName);
    if (!file)
    {
        emit error(tr("Problem opening file"));
        setFileDownloaded("");
        return "";
    }

    startRequest();
    setFileDownloaded(fileName);
    return fileName;
}
void HttpDownload::preProcessUrl()
{
    if (m_url.host() == "www.dropbox.com")
    {
        QUrlQuery myQuery;
        myQuery.addQueryItem("raw","1");
        m_url.setQuery(myQuery);
    }
}

void HttpDownload::startRequest()
{
    httpRequestAborted = false;

    reply = qnam.get(QNetworkRequest(m_url));
    connect(reply, &QNetworkReply::finished, this, &HttpDownload::httpFinished);
    connect(reply, &QIODevice::readyRead, this, &HttpDownload::httpReadyRead);

    QObject::connect(reply, &QNetworkReply::downloadProgress, this, &HttpDownload::downloadProgress);
    QObject::connect(reply, &QNetworkReply::finished, this, &HttpDownload::finished);
}

void HttpDownload::httpFinished()
{
    QFileInfo fi;
    if (file) {
        fi.setFile(file->fileName());
        file->close();
        delete file;
        file = Q_NULLPTR;
    }

    if (httpRequestAborted) {
        reply->deleteLater();
        reply = Q_NULLPTR;
        return;
    }

    if (reply->error()) {
        QFile::remove(fi.absoluteFilePath());
        emit error(tr("Download failed:\n%1.").arg(reply->errorString()));
        reply->deleteLater();
        reply = Q_NULLPTR;
        return;
    }

    const QVariant redirectionTarget = reply->attribute(QNetworkRequest::RedirectionTargetAttribute);
    reply->deleteLater();
    reply = Q_NULLPTR;

    if (!redirectionTarget.isNull()) {
        setUrl(m_url.resolved(redirectionTarget.toUrl()));
        file = openFileForWrite(fi.absoluteFilePath());
        if (!file) {
            return;
        }
        startRequest();
        return;
    }
    emit finishedDownload();
}

QFile *HttpDownload::openFileForWrite(const QString &fileName)
{
    QScopedPointer<QFile> file(new QFile(fileName));
    if (!file->open(QIODevice::WriteOnly)) {
       // QMessageBox::information(this, tr("Error")
       //                          , tr("Unable to save the file %1: %2.").arg(QDir::toNativeSeparators(fileName)
       //                          , file->errorString()));
        emit error(tr("Unable to save the file %1: %2.")
                   .arg(QDir::toNativeSeparators(fileName)));
        return Q_NULLPTR;
    }
    return file.take();
}

void HttpDownload::httpReadyRead()
{
    // this slot gets called every time the QNetworkReply has new data.
    // We read all of its new data and write it into the file.
    // That way we use less RAM than when reading it at the finished()
    // signal of the QNetworkReply
    if (file)
        file->write(reply->readAll());
}

void HttpDownload::slotAuthenticationRequired(QNetworkReply *, QAuthenticator *authenticator)
{
    emit authenticationRequired();
    authenticator->setUser(user());
    authenticator->setPassword(password());
}

QUrl HttpDownload::url() const
{
    return m_url;
}

QString HttpDownload::user() const
{
    return m_user;
}

QString HttpDownload::password() const
{
    return m_password;
}

QString HttpDownload::fileDownloaded() const
{
    return m_fileDownloaded;
}

void HttpDownload::setUrl(QUrl url)
{
    if (m_url == url)
        return;

    m_url = url;
    emit urlChanged(url);
}



void HttpDownload::setUser(QString user)
{
    if (m_user == user)
        return;

    m_user = user;
    emit userChanged(user);
}

void HttpDownload::setPassword(QString password)
{
    if (m_password == password)
        return;

    m_password = password;
    emit passwordChanged(password);
}

void HttpDownload::setFileDownloaded(QString fileDownloaded)
{
    if (m_fileDownloaded == fileDownloaded)
        return;

    m_fileDownloaded = fileDownloaded;
    emit fileDownloadedChanged(fileDownloaded);
}


