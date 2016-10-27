#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "beziqueDeck.h"
#include "game.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    Game game;
    game.start();

    return app.exec();
}
