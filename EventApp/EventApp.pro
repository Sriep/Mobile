# += qml quick
QT += quick quickcontrols2
CONFIG += c++11

SOURCES += main.cpp \
    ../EventAppShared/eacontainer.cpp \
    ../EventAppShared/eaconstruction.cpp \
    ../EventAppShared/eainfo.cpp \
    ../EventAppShared/httpdownload.cpp \
    ../EventAppShared/eaitemlist.cpp \
    ../EventAppShared/csv.cpp

HEADERS += \
    ../EventAppShared/eainfo.h \
    ../EventAppShared/eacontainer.h \
    ../EventAppShared/eaconstruction.h \
    ../EventAppShared/httpdownload.h \
    ../EventAppShared/eaitemlist.h \
    ../EventAppShared/csv.h

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

#unix:!macx: LIBS += -L$$PWD/../build-EventAppShared-Desktop_Qt_5_7_0_GCC_64bit-Debug/ -lEventAppShared

#android  {
#  unix:!macx: LIBS += -L$$PWD/../build-EventAppShared-Android_for_armeabi_v7a_GCC_4_9_Qt_5_7_0-Debug/ -lEventAppShared
#}

INCLUDEPATH += $$PWD/../EventAppShared
DEPENDPATH += $$PWD/../EventAppShared




DISTFILES += \
    qml/DownloadEventForm.ui.qml \
    qml/EaHeaderForm.ui.qml \
    images/menuW@4x.png \
    images/menuW@3x.png \
    images/menuW@2x.png \
    images/menuW.png \
    images/menu@4x.png \
    images/menu@3x.png \
    images/menu@2x.png \
    images/menu.png \
    images/drawerW@4x.png \
    images/drawerW@3x.png \
    images/drawerW@2x.png \
    images/drawerW.png \
    images/drawer@4x.png \
    images/drawer@3x.png \
    images/drawer@2x.png \
    images/drawer.png \
    qml/EaHeader.qml \
    MainStackForm.ui.qml \
    qml/ListDelegateForm.ui.qml \
    qml/DrawerModel.qml \
    sharedqml/common.js \
    sharedqml/DataList.qml \
    sharedqml/DataListDelegate.qml

FORMS +=


