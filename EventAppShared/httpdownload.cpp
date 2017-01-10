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

QString HttpDownload::downloadFileData(const QString url)
{
    m_senddata = true;
    return downloadFile(url);
}

//QString HttpDownload::downloadFile(QUrl url)
QString HttpDownload::downloadFile(const QString url)
{
    m_url = QUrl(url);
    m_senddata = true;
    //const QString urlSpec = urlLineEdit->text().trimmed();
    if (m_url.isEmpty())
    {
        emit error(tr("Empty url"));
        return "";
    }

    // Add query back in
    int firstQ = url.indexOf('?');
    if ( firstQ > 1)
    {
        QString queryText = url.right(url.size() - firstQ -1);
        QUrlQuery  myQuery(queryText);
        m_url.setQuery(myQuery);
    }

    //preProcessUrl();
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
    if (!file && !m_senddata)
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
    if (!redirectionTarget.isNull()) {
        setUrl(m_url.resolved(redirectionTarget.toUrl()));
        file = openFileForWrite(fi.absoluteFilePath());
        if (!file) {
            return;
        }
        startRequest();
        return;
    }
    else  if (m_senddata)
    {
         m_downloadData = reply->readAll();
         //emit downloadedData(m_downloadData);
         emit downloadDataFinished();
    }

    reply->deleteLater();
    reply = Q_NULLPTR;

    emit finishedDownload();
}

QFile *HttpDownload::openFileForWrite(const QString &fileName)
{
    QScopedPointer<QFile> file(new QFile(fileName));
    if (!file->open(QIODevice::WriteOnly) && !m_senddata) {
       // QMessageBox::information(this, tr("Error")
       //                          , tr("Unable to save the file %1: %2.").arg(QDir::toNativeSeparators(fileName)
       //                          , file->errorString()));
        emit error(tr("Unable to save the file %1: %2.")
                   .arg(QDir::toNativeSeparators(fileName)));
        return Q_NULLPTR;
    }
    return file.take();
}

bool HttpDownload::sendFile() const
{
    return m_senddata;
}

void HttpDownload::setSendFile(bool sendFile)
{
    m_senddata = sendFile;
}

QByteArray HttpDownload::downloadData() const
{
    return m_downloadData;
}

bool HttpDownload::storeData() const
{
    return m_senddata;
}

void HttpDownload::httpReadyRead()
{
    // this slot gets called every time the QNetworkReply has new data.
    // We read all of its new data and write it into the file.
    // That way we use less RAM than when reading it at the finished()
    // signal of the QNetworkReply
    if (m_senddata)
    {
        //m_downloadData.append(reply->readAll());
        //emit downloadedData(reply->readAll())
    }
    else if (file)
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


