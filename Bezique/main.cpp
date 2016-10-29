#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "beziquehand.h"
#include "game.h" 
#include "player.h"
#include "card.h"
#include "gamedata.h"
#include "test.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    //qmlRegisterType<Test>("Bezique", 1,0, "Test");
    qmlRegisterType<BeziqueHand>("Bezique", 1,0, "BeziqueHand");
    qmlRegisterType<Card>("Bezique", 1,0, "Card");
    qmlRegisterType<GameData>("Bezique", 1,0, "GameData");


    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    //Game game;
    //game.start();

    return app.exec();
}
