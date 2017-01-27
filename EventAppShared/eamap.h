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
    Q_PROPERTY(double latitude READ latitude WRITE setLatitude NOTIFY latitudeChanged)
    Q_PROPERTY(double longitude READ longitude WRITE setLongitude NOTIFY longitudeChanged)
    Q_PROPERTY(int zoomLevel READ zoomLevel WRITE setZoomLevel NOTIFY zoomLevelChanged)
    Q_PROPERTY(bool useCurrent READ useCurrent WRITE setUseCurrent NOTIFY useCurrentChanged)

    QString m_maptype = "mapbox";
    QString m_accessToken = "";
    QString m_mapId = "";
    double m_latitude = 0;
    double m_longitude = 0;
    int m_zoomLevel = 14;
    bool m_useCurrent = true;

public:
    EAMap();

    void read(const QJsonObject &json);
    void write(QJsonObject &json);

    QString maptype() const;
    QString accessToken() const;
    QString mapId() const;
    double latitude() const;
    double longitude() const;
    int zoomLevel() const;
    bool useCurrent() const;

signals:
    void maptypeChanged(QString maptype);
    void accessTokenChanged(QString accessToken);
    void mapIdChanged(QString mapId);
    void latitudeChanged(double latitude);
    void longitudeChanged(double longitude);
    void zoomLevelChanged(int zoomLevel);
    void useCurrentChanged(bool useCurrent);

public slots:
    void setMaptype(QString maptype);
    void setAccessToken(QString accessToken);
    void setMapId(QString mapId);
    void setLatitude(double latitude);
    void setLongitude(double longitude);
    void setZoomLevel(int zoomLevel);
    void setUseCurrent(bool useCurrent);
};

#endif // EAMAP_H
