#-------------------------------------------------
#
# Project created by QtCreator 2016-11-17T12:21:59
#
#-------------------------------------------------

QT += qml quick
CONFIG += c++11

TARGET = EventAppShared
TEMPLATE = lib

DEFINES += EVENTAPPSHARED_LIBRARY

SOURCES += eventappshared.cpp \
    eainfo.cpp \
    eacontainer.cpp \
    eaconstruction.cpp \
    httpdownload.cpp \
    eapropertylist.cpp \
    eaitemlist.cpp \
    csv.cpp \
    picturelistimageprovider.cpp \
    eaitem.cpp \
    firebase.cpp \
    eauser.cpp \
    eaquestion.cpp \
    eaobjdisplay.cpp \
    simplecrypt.cpp \
    eamap.cpp \
    eastrings.cpp \
    eaicons.cpp

HEADERS += eventappshared.h\
    eventappshared_global.h \
    eainfo.h \
    eacontainer.h \
    eaconstruction.h \
    httpdownload.h \
    eapropertylist.h \
    eaitemlist.h \
    csv.h \
    picturelistimageprovider.h \
    eaitemlistbase.h \
    eaitem.h \
    firebase.h \
    eauser.h \
    eaquestion.h \
    eaobjdisplay.h \
    simplecrypt.h \
    eamap.h \
    eastrings.h \
    eaicons.h

unix {
    target.path = /usr/lib
    INSTALLS += target
}

DISTFILES +=


RESOURCES +=
