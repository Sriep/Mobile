#ifndef EAMAP_H
#define EAMAP_H

#include <QQuickItem>
#include <QJsonObject>

class EAMap : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString maptype READ maptype WRITE setMaptype NOTIFY maptypeChanged)
    Q_PROPERTY(QString accessToken READ accessToken WRITE setAccessToken NOTIFY accessTokenChanged)
    Q_PROPERTY(QString mapId READ mapId WRITE setMapId NOTIFY mapIdChanged)
    Q_PROPERTY(int latitude READ latitude WRITE setLatitude NOTIFY latitudeChanged)
    Q_PROPERTY(int longitude READ longitude WRITE setLongitude NOTIFY longitudeChanged)
    Q_PROPERTY(int zoomLevel READ zoomLevel WRITE setZoomLevel NOTIFY zoomLevelChanged)
    Q_PROPERTY(bool useCurrent READ useCurrent WRITE setUseCurrent NOTIFY useCurrentChanged)

    QString m_maptype = "";
    QString m_accessToken = "";
    QString m_mapId = "";
    int m_latitude = 0;
    int m_longitude = 0;
    int m_zoomLevel = 14;
    bool m_useCurrent = true;

public:
    EAMap();

    void read(const QJsonObject &json);
    void write(QJsonObject &json);

    QString maptype() const;
    QString accessToken() const;
    QString mapId() const;
    int latitude() const;
    int longitude() const;
    int zoomLevel() const;
    bool useCurrent() const;

signals:
    void maptypeChanged(QString maptype);
    void accessTokenChanged(QString accessToken);
    void mapIdChanged(QString mapId);
    void latitudeChanged(int latitude);
    void longitudeChanged(int longitude);
    void zoomLevelChanged(int zoomLevel);
    void useCurrentChanged(bool useCurrent);

public slots:
    void setMaptype(QString maptype);
    void setAccessToken(QString accessToken);
    void setMapId(QString mapId);
    void setLatitude(int latitude);
    void setLongitude(int longitude);
    void setZoomLevel(int zoomLevel);
    void setUseCurrent(bool useCurrent);
};

#endif // EAMAP_H
