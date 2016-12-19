#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "eainfo.h"
#include "eacontainer.h"
#include "eaconstruction.h"
#include "eaitemlist.h"
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
    qmlRegisterType<EAItemList>("EventAppData", 1,0, "EAItemList");
    qmlRegisterType<HttpDownload>("EventAppData", 1,0, "HttpDownload");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("applicationPath", "file://"+qApp->applicationDirPath()+ "/");
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
