#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "eainfo.h"
#include "eacontainer.h"
#include "eaconstruction.h"
#include "easpeakers.h"
#include "ealistmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    app.setOrganizationName("Pierses");
    app.setOrganizationDomain("eventapps.com");
    app.setApplicationName("PiersesEventAppDesigner");

    qmlRegisterType<EAContainer>("EventAppData", 1,0, "EAContainer");
    qmlRegisterType<EAConstruction>("EventAppData", 1,0, "EAConstruction");
    qmlRegisterType<EAInfo>("EventAppData", 1,0, "EAInfo");
    qmlRegisterType<EASpeakers>("EventAppData", 1,0, "EASpeakers");
    qmlRegisterType<EAListModel>("EventAppData", 1,0, "EAListModel");


    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
