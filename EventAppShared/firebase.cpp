#include "firebase.h"
#include <string.h>
#include <QIODevice>
#include <QJsonDocument>
#include <QJsonObject>
#include <QDateTime>
#include <QCryptographicHash>
#include <QtDebug>
#include <QBuffer>

Firebase::Firebase(QObject *parent) :
    QObject(parent)
{

}
void Firebase::init()
{
    manager=new QNetworkAccessManager(this);
    connect(manager,SIGNAL(finished(QNetworkReply*)),this,SLOT(replyFinished(QNetworkReply*)));
}
Firebase::Firebase(QString hostName)
{
    host=hostName;
    currentNode="";
    init();
}
void Firebase::setToken(QString token)
{
    firebaseToken=token;
}

/*
//Not implimented yet
QString Firebase::getToken(const QString& serviceAccount, const QByteArray& privateKey)
{
    QString jwtStr =  "{\"alg\":\"RS256\",\"typ\":\"JWT\"}";
    QByteArray jwtHeader(jwtStr.toUtf8());
    QByteArray jwtHeaderBase64 = jwtHeader.toBase64(QByteArray::Base64UrlEncoding);
    qDebug() << "jwt header: " << jwtHeader;
    qDebug() << "jwt header base64url: " << jwtHeaderBase64;


    //iss   The email address of the service account.
    //      e.g 761326798069-r5mljlln1rd4lrbhg75efgigp36m78j5@developer.gserviceaccount.com
    //scope A space-delimited list of the permissions that the
    //      application requests.
    //aud 	A descriptor of the intended target of the assertion.
    //      When making an access token request this value is always
    //      https://www.googleapis.com/oauth2/v4/token.
    //exp 	The expiration time of the assertion, specified as seconds
    //      since 00:00:00 UTC, January 1, 1970. This value has a maximum of
    //      1 hour after the issued time.
    //iat 	The time the assertion was issued, specified as seconds since
    //      00:00:00 UTC, January 1, 1970.
    QJsonObject jwtClaimObj;
    jwtClaimObj["iss"] = serviceAccount;
    jwtClaimObj["scope"] = "https://www.googleapis.com/auth/devstorage.readonly";
    jwtClaimObj["aud"] = "https://www.googleapis.com/oauth2/v4/token";
    QDateTime time = QDateTime::currentDateTime();
    jwtClaimObj["exp"] = (int) time.toTime_t() + 60*60;
    jwtClaimObj["iat"] = (int) time.toTime_t();
    QJsonDocument jwtClaimDoc(jwtClaimObj);
    QByteArray jwtClaim(jwtClaimDoc.toJson());
    QByteArray jwtClaimBase64 = jwtClaim.toBase64(QByteArray::Base64UrlEncoding);

    QByteArray bytesToSign = jwtHeaderBase64 + "." + jwtClaimBase64;
    //QByteArray signedMessage = signMessage(bytesToSign, privateKey);

    QCryptographicHash cryptoHash(QCryptographicHash::Sha256);
    cryptoHash.addData(privateKey);


}

QByteArray Firebase::signMessage(QByteArray messageToSign, QByteArray privateKey)
{
    //CryptoPP::RSASSA_PKCS1v15_SHA_Signer signer(privateKey);
    //typedef RSASS<PKCS1v15,SHA>::Signer RSASSA_PKCS1v15_SHA_Signer;
   // typedef RSASS<CryptoPP::PKCS1v15,CryptoPP::SHA>::Signer RSASSA_PKCS1v15_SHA_Signer;
    typedef RSASS<CryptoPP::PKCS1v15,CryptoPP::SHA>::Verifier RSASSA_PKCS1v15_SHA_Verifier;
  // CryptoPP::RSASS<CryptoPP::PKCS1v15,CryptoPP::SHA>::Signer signer1(privateKey);

   AutoSeededRandomPool rng;
   InvertibleRSAFunction parameters;
   parameters.GenerateRandomWithKeySize(rng, 1536);
   RSA::PrivateKey myPrivateKey(parameters);
   RSA::PublicKey myPublicKey(parameters);

   // Message
   string message = "Yoda said, Do or Do Not. There is no try.";
   message = messageToSign.toStdString();

   // Signer object
   //CryptoPP::RSASSA_PKCS1v15_SHA_Signer signer(privateKey);

   // Create signature space
   size_t length = signer.MaxSignatureLength();

   //typedef CryptoPP::SecBlock<byte> ::SecByteBlock;
   CryptoPP::SecByteBlock signature(length);

   // Sign message
   length = signer.SignMessage(rng, (const byte*) message.c_str(),
       message.length(), signature);

   // Resize now we know the true size of the signature
   signature.resize(length);

   // Verifier object
   RSASSA_PKCS1v15_SHA_Verifier verifier(myPublicKey);

   // Verify
   bool result = verifier.VerifyMessage((const byte*)message.c_str(),
       message.length(), signature, signature.size());

   // Result
   if(true == result) {
       cout << "Signature on message verified" << endl;
   } else {
       cout << "Message verification failed" << endl;
   }
}*/

Firebase::Firebase(QString hostName,QString child)
{
    host=hostName
            .append(child).append("/");
    latestNode=child;
    init();
}
Firebase* Firebase::child(QString childName)
{
    Firebase *childNode=new Firebase(host,childName);
    childNode->setToken(firebaseToken);
    return childNode;
}
void Firebase::open(const QUrl &url)
{
    QNetworkRequest request(url);
    request.setRawHeader("Accept",
                         "text/event-stream");
    QNetworkReply *_reply = manager->get(request);
    connect(_reply, &QNetworkReply::readyRead, this, &Firebase::eventReadyRead);
    connect(_reply, &QNetworkReply::finished, this, &Firebase::eventFinished);
}
void Firebase::eventFinished()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
    if (reply)
    {
        QUrl redirectUrl = reply->attribute(QNetworkRequest::RedirectionTargetAttribute).toUrl();
        if (!redirectUrl.isEmpty())
        {
            reply->deleteLater();
            open(redirectUrl);
            return;
        }
        reply->deleteLater();
    }
}
void Firebase::eventReadyRead()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
    if(reply)
    {
        QByteArray line=reply->readLine();
        if(!line.isEmpty())
        {
            QByteArray eventName=trimValue(line);
            line=reply->readAll();
            if(eventName=="put")
            {
                //DataSnapshot *dataSnapshot=new DataSnapshot(line);
                QString dataSnapshot(line);
                emit eventDataChanged(dataSnapshot);
            }
        }
    }
    reply->readAll();
}

void Firebase::onReadyRead(QNetworkReply *reply)
{
    /*qDebug()<<"incoming data";
    qDebug()<<reply->readAll();*/
}
void Firebase::replyFinished(QNetworkReply *reply)
{
    //qDebug()<<reply->readAll();
    //QString data=QString(reply->readAll());
    //emit eventResponseReady(data);
    emit eventResponseReady(reply->readAll());
}

void Firebase::setValue(QString strVal)
{
    //Json data creation
    QNetworkRequest request(buildPath(1));
    request.setHeader(QNetworkRequest::ContentTypeHeader,
                      "application/x-www-form-urlencoded");
    QBuffer *buffer=new QBuffer();
    buffer->open((QBuffer::ReadWrite));
    buffer->write(createJson(strVal).toUtf8());
    buffer->seek(0);

    //QByteArray ba = buffer->buffer();
    //QString stb(ba);
    //qDebug() << stb;

     ////* To be able to send "PATCH" request sendCustomRequest method is used.
    //// * sendCustomRequest requires a QIOdevice so QBuffer is used.
     //* I had to seek 0 because it starts reading where it paused.

    manager->sendCustomRequest(request,"PATCH",buffer);
    buffer->close();
}

void Firebase::setValue(QJsonDocument jsonDoc
                        , const QString &verb
                        , const QString& endPath)
{
    //Json data creation
    QNetworkRequest request(buildPath(1, endPath));
    request.setHeader(QNetworkRequest::ContentTypeHeader,
                      "application/x-www-form-urlencoded");
    QByteArray jsonBA = jsonDoc.toJson(QJsonDocument::Compact);

    QBuffer *buffer=new QBuffer();
    buffer->open((QBuffer::ReadWrite));
    buffer->write(jsonBA);
    buffer->seek(0);

    QByteArray verbBA = verb.toUtf8();
    manager->sendCustomRequest(request, verbBA ,buffer);
    buffer->close();
}

void Firebase::getValue()
{
    QNetworkRequest request(buildPath(0));
    manager->get(request);
}
void Firebase::getValue(QUrl url)
{
    QNetworkRequest request(url);
    manager->get(request);
}

void Firebase::listenEvents()
{
    open(buildPath(0));
}
void Firebase::deleteValue()
{
    QNetworkRequest request(buildPath(0));
    manager->deleteResource(request);
}
QString Firebase::createJson(QString str)
{
    QString data=QString(QString("{").append("\"").append(latestNode).append("\"").append(":").append("\"").append(str).append("\"").append(QString("}")));
    return data;
}

QUrl Firebase::getPath()
{
    return QUrl(buildPath(0));
}
QString Firebase::buildPath(int mode, const QString endPath)
{
    QString destination="";
    if(mode)
    {
        //host.replace(QString("/").append(latestNode).append("/"),"");
        //destination
        //        .append(host)
        //        .append("/.json");
        destination.append(host).append(endPath).append(".json");
    }
    else
    {
        destination
                .append(host)
                .append(currentNode)
                .append(".json");

    }
    if(!firebaseToken.isEmpty())
        destination.append("?auth=").append(firebaseToken);
    return destination;

}

QString Firebase::buildSetPath(const QString endPath)
{
     QString destination="";
     destination.append(host).append(endPath).append(".json");
     if(!firebaseToken.isEmpty())
         destination.append("?auth=").append(firebaseToken);
     return destination;
}

QString Firebase::buildGetPath()
{
    QString destination="";
    destination.append(host).append(currentNode).append(".json");
    if(!firebaseToken.isEmpty())
        destination.append("?auth=").append(firebaseToken);
    return destination;
}

QByteArray Firebase::trimValue(const QByteArray &line) const
{
    QByteArray value;
    int index = line.indexOf(':');
    if (index > 0)
        value = line.right(line.size() - index  - 1);
    return value.trimmed();
}

