#ifndef PICTURELISTIMAGEPROVIDER_H
#define PICTURELISTIMAGEPROVIDER_H
#include <QQuickImageProvider>
#include <QString>
#include <QImage>
#include <QSize>
#include <QJsonArray>

class PictureListImageProvider :  public QQuickImageProvider
{
public:
    PictureListImageProvider(const QJsonArray& pictures);
    PictureListImageProvider(const QJsonArray& pictures, QJsonValue eventIcon);

    virtual ~PictureListImageProvider();

    virtual QImage requestImage(const QString &id
                                , QSize *size
                                , const QSize &requestedSize);    

    virtual QPixmap	requestPixmap(const QString &id
                                      , QSize *size
                                      , const QSize &requestedSize);

    virtual QQuickTextureFactory *requestTexture(const QString &id
                                               , QSize *size
                                               , const QSize &requestedSize);

private:
    const QJsonArray& pictures;
    const QJsonValue eventIcon;
    //bool hasEvnetIcon;
};

#endif // PICTURELISTIMAGEPROVIDER_H
