#include "eamap.h"

EAMap::EAMap()
{    
}

void EAMap::read(const QJsonObject &json)
{
    setMaptype(json["mapType"].toString());
    setAccessToken(json["accessToken"].toString());
    setMapId(json["mapId"].toString());
    setLatitude(json["latitude"].toInt());
    setLongitude(json["longitude"].toInt());
    setZoomLevel(json["zoomLevel"].toInt());
    setUseCurrent(json["useCurrent"].toBool());
}

void EAMap::write(QJsonObject &json)
{
    json["mapType"] = maptype();
    json["accessToken"] = accessToken();
    json["mapId"] = mapId();
    json["latitude"] = latitude();
    json["longitude"] = longitude();
    json["zoomLevel"] = zoomLevel();
    json["useCurrent"] = useCurrent();
}

QString EAMap::maptype() const
{
    return m_maptype;
}

QString EAMap::accessToken() const
{
    return m_accessToken;
}

QString EAMap::mapId() const
{
    return m_mapId;
}

double EAMap::latitude() const
{
    return m_latitude;
}

double EAMap::longitude() const
{
    return m_longitude;
}

int EAMap::zoomLevel() const
{
    return m_zoomLevel;
}

bool EAMap::useCurrent() const
{
    return m_useCurrent;
}

void EAMap::setMaptype(QString maptype)
{
    if (m_maptype == maptype)
        return;

    m_maptype = maptype;
    emit maptypeChanged(maptype);
}

void EAMap::setAccessToken(QString accessToken)
{
    if (m_accessToken == accessToken)
        return;

    m_accessToken = accessToken;
    emit accessTokenChanged(accessToken);
}

void EAMap::setMapId(QString mapId)
{
    if (m_mapId == mapId)
        return;

    m_mapId = mapId;
    emit mapIdChanged(mapId);
}

void EAMap::setLatitude(double latitude)
{
    if (m_latitude == latitude)
        return;

    m_latitude = latitude;
    emit latitudeChanged(latitude);
}

void EAMap::setLongitude(double longitude)
{
    if (m_longitude == longitude)
        return;

    m_longitude = longitude;
    emit longitudeChanged(longitude);
}

void EAMap::setZoomLevel(int zoomLevel)
{
    if (m_zoomLevel == zoomLevel)
        return;

    m_zoomLevel = zoomLevel;
    emit zoomLevelChanged(zoomLevel);
}

void EAMap::setUseCurrent(bool useCurrent)
{
    if (m_useCurrent == useCurrent)
        return;

    m_useCurrent = useCurrent;
    emit useCurrentChanged(useCurrent);
}
