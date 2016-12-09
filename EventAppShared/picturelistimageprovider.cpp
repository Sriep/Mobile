#include <QPixmap>
#include "picturelistimageprovider.h"
#include "eaitemlist.h"

PictureListImageProvider::PictureListImageProvider(const QJsonArray &pictures)
    : QQuickImageProvider(QQuickImageProvider::Image), pictures(pictures)
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
    if (index < pictures.size())
    {
        QPixmap pix = pixmapFrom(pictures[index]);
        QImage image = pix.toImage();
        image.scaled(requestedSize,  Qt::KeepAspectRatio);
        *size = image.size();
        return image;
    }
    else
    {
        QPixmap pix(requestedSize);
        pix.fill("Yellow");
        return pix.toImage();
        // return QQuickImageProvider::requestImage(id, size, requestedSize);

    }

}
