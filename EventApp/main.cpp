#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "eainfo.h"
#include "eacontainer.h"
#include "eaconstruction.h"
#include "httpdownload.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    app.setOrganizationName("Pierses");
    app.setOrganizationDomain("eventapps.com");
    app.setApplicationName("PiersesEventApp");

    qmlRegisterType<EAContainer>("EventAppData", 1,0, "EAContainer");
    qmlRegisterType<EAConstruction>("EventAppData", 1,0, "EAConstruction");
    qmlRegisterType<EAInfo>("EventAppData", 1,0, "EAInfo");
    qmlRegisterType<HttpDownload>("EventAppData", 1,0, "HttpDownload");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
