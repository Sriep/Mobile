# += qml quick
QT += quick quickcontrols2
CONFIG += c++11

SOURCES += main.cpp \
    ../EventAppShared/eacontainer.cpp \
    ../EventAppShared/eaconstruction.cpp \
    ../EventAppShared/eainfo.cpp \
    ../EventAppShared/httpdownload.cpp \
    ../EventAppShared/eaitemlist.cpp \
    ../EventAppShared/csv.cpp \
    ../EventAppShared/picturelistimageprovider.cpp \
    ../EventAppShared/eaitem.cpp \
    ../EventAppShared/eaitemcollection.cpp \
    ../EventAppShared/eaitemlistbase.cpp \
    ../EventAppShared/eapropertylist.cpp \
    ../EventAppShared/eventappshared.cpp \
    ../EventAppShared/firebase.cpp

HEADERS += \
    ../EventAppShared/eainfo.h \
    ../EventAppShared/eacontainer.h \
    ../EventAppShared/eaconstruction.h \
    ../EventAppShared/httpdownload.h \
    ../EventAppShared/eaitemlist.h \
    ../EventAppShared/csv.h \
    ../EventAppShared/picturelistimageprovider.h \
    ../EventAppShared/eaitem.h \
    ../EventAppShared/eaitemcollection.h \
    ../EventAppShared/eaitemlistbase.h \
    ../EventAppShared/eapropertylist.h \
    ../EventAppShared/eventappshared_global.h \
    ../EventAppShared/eventappshared.h \
    ../EventAppShared/firebase.h

RESOURCES += qml.qrc \
   qmlShared.qrc
#  ../EventAppShared/qmlShared.qrc

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
    qml/main.qml \
    qmldir \
    ../build-EventApp-Android_for_armeabi_v7a_GCC_4_9_Qt_5_7_0-Debug/android-build/AndroidManifest.xml \
    ../build-EventApp-Android_for_armeabi_v7a_GCC_4_9_Qt_5_7_0-Debug/android-build/gradle/wrapper/gradle-wrapper.jar \
    ../build-EventApp-Android_for_armeabi_v7a_GCC_4_9_Qt_5_7_0-Debug/android-build/gradlew \
    ../build-EventApp-Android_for_armeabi_v7a_GCC_4_9_Qt_5_7_0-Debug/android-build/res/values/libs.xml \
    ../build-EventApp-Android_for_armeabi_v7a_GCC_4_9_Qt_5_7_0-Debug/android-build/build.gradle \
    ../build-EventApp-Android_for_armeabi_v7a_GCC_4_9_Qt_5_7_0-Debug/android-build/gradle/wrapper/gradle-wrapper.properties \
    ../build-EventApp-Android_for_armeabi_v7a_GCC_4_9_Qt_5_7_0-Debug/android-build/gradlew.bat

FORMS +=

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/../build-EventApp-Android_for_armeabi_v7a_GCC_4_9_Qt_5_7_0-Debug/android-build


