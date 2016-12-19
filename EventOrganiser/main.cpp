#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <qtwebengineglobal.h>
//#include <QtWebEngine>
#include <QtWebView>
#include "eainfo.h"
#include "eacontainer.h"
#include "eaconstruction.h"
#include "eaitemlist.h"
#include "eaitemcollection.h"
#include "eaitem.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QtWebView::initialize();
    QtWebEngine::initialize();

    app.setOrganizationName("Pierses");
    app.setOrganizationDomain("eventapps.com");
    app.setApplicationName("PiersesEventAppDesigner");

    qmlRegisterType<EAContainer>("EventAppData", 1,0, "EAContainer");
    qmlRegisterType<EAConstruction>("EventAppData", 1,0, "EAConstruction");
    qmlRegisterType<EAInfo>("EventAppData", 1,0, "EAInfo");
    qmlRegisterType<EAItemList>("EventAppData", 1,0, "EAItemList");
    qmlRegisterType<EAItemCollection>("EventAppData", 1,0, "EAItemCollection");
    qmlRegisterType<EAItemListBase>("EventAppData", 1,0, "EAItemListBase");
    qmlRegisterType<EAItem>("EventAppData", 1,0, "EAItem");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("applicationPath", "file://"+qApp->applicationDirPath()+ "/");
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
