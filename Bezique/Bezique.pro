QT += qml quick

CONFIG += c++11
HEADERS += \
    beziqueDeck.h \
    game.h \
    player.h \
    aiplayer.h \
    controledplayer.h \
    card.h \
    test.h \
    beziquehand.h \
    gamedata.h
SOURCES += main.cpp \
    beziqueDeck.cpp \
    game.cpp \
    player.cpp \
    aiplayer.cpp \
    controledplayer.cpp \
    card.cpp \
    test.cpp \
    beziquehand.cpp \
    gamedata.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=


