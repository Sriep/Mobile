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
    ealistmodel.cpp \
    easpeakers.cpp \
    eaitemlist.cpp \
    csv.cpp

HEADERS += eventappshared.h\
        eventappshared_global.h \
    eainfo.h \
    eacontainer.h \
    eaconstruction.h \
    httpdownload.h \
    eapropertylist.h \
    ealistmodel.h \
    easpeakers.h \
    eaitemlist.h \
    csv.h

unix {
    target.path = /usr/lib
    INSTALLS += target
}

DISTFILES += \
    EventAppShared.pro.user \
    content/common.js \
    content/qmldir \
    content/DataList.qml \
    common.js \
    Untitled Document \
    qmldir \
    DataListDelegate.qml \
    DataList.qml \
    qml.qrs \
    common.js \
    qmldir \
    DataListDelegate.qml \
    DataList.qml

RESOURCES += \
    qmlShared.qrc
