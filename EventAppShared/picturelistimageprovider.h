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

    virtual ~PictureListImageProvider();
    virtual QImage requestImage(const QString &id
                                , QSize *size
                                , const QSize &requestedSize);    
private:
    const QJsonArray& pictures;
};

#endif // PICTURELISTIMAGEPROVIDER_H
