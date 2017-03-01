#include <QPixmap>
#include "picturelistimageprovider.h"
#include "eaitemlist.h"

PictureListImageProvider::PictureListImageProvider(const QJsonArray &pictures)
    : QQuickImageProvider(QQuickImageProvider::Image), pictures(pictures)
{   
}

PictureListImageProvider::PictureListImageProvider(const QJsonArray &pictures
                                                   , QJsonValue eventIcon)
    : QQuickImageProvider(QQuickImageProvider::Image)
    , pictures(pictures)
    , eventIcon(eventIcon)
{
}

PictureListImageProvider::~PictureListImageProvider()
{
}

QImage PictureListImageProvider::requestImage(const QString &id
                                              , QSize *size
                                              , const QSize &requestedSize)
{
    int index = id.toInt();
    if (0 <= index &&index < pictures.size())
    {
        QPixmap pix = pixmapFrom(pictures[index]);
        QImage image = pix.toImage();
        image.scaled(requestedSize,  Qt::KeepAspectRatio);
        *size = image.size();
        return image;
    }
    else if (-1 == index)
    {
        QPixmap pix = pixmapFrom(eventIcon);
        QImage image = pix.toImage();
        image.scaled(requestedSize,  Qt::KeepAspectRatio);
        *size = image.size();
        return image;
    }
    else
    {
        QSize s(requestedSize.width()>0 ? requestedSize.width() : 1
              , requestedSize.height()>0 ? requestedSize.height() : 1);
        QPixmap pix(s);
        pix.fill("Yellow");
        return pix.toImage();
        // return QQ uickImageProvider::requestImage(id, size, requestedSize);
    }
}

QPixmap PictureListImageProvider::requestPixmap(const QString &id
                                                , QSize *size
                                                , const QSize &requestedSize)
{
    return QQuickImageProvider::requestPixmap(id, size, requestedSize);
}

QQuickTextureFactory *PictureListImageProvider::requestTexture(
                                                    const QString &id
                                                   , QSize *size
                                                   , const QSize &requestedSize)
{
   return QQuickImageProvider::requestTexture(id, size, requestedSize);
}

