# += qml quick
QT += network
QT += quick quickcontrols2
QT += qml quick webview
QT += widgets
CONFIG += c++11

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
DEFINES += QTADMOB_QML
include(../QtAdMob/QtAdMob.pri)


SOURCES += main.cpp \
    ../EventAppShared/eacontainer.cpp \
    ../EventAppShared/eaconstruction.cpp \
    ../EventAppShared/eainfo.cpp \
    ../EventAppShared/httpdownload.cpp \
    ../EventAppShared/eaitemlist.cpp \
    ../EventAppShared/csv.cpp \
    ../EventAppShared/picturelistimageprovider.cpp \
    ../EventAppShared/eaitem.cpp \
    ../EventAppShared/eapropertylist.cpp \
    ../EventAppShared/eventappshared.cpp \
    ../EventAppShared/firebase.cpp \
    ../EventAppShared/eauser.cpp \
    ../EventAppShared/eaquestion.cpp \
    ../EventAppShared/eaobjdisplay.cpp \
    ../EventAppShared/simplecrypt.cpp \
    ../EventAppShared/eamap.cpp \
    ../EventAppShared/eastrings.cpp \
    ../EventAppShared/assistant.cpp


HEADERS += \
    ../EventAppShared/eainfo.h \
    ../EventAppShared/eacontainer.h \
    ../EventAppShared/eaconstruction.h \
    ../EventAppShared/httpdownload.h \
    ../EventAppShared/eaitemlist.h \
    ../EventAppShared/csv.h \
    ../EventAppShared/picturelistimageprovider.h \
    ../EventAppShared/eaitem.h \
    ../EventAppShared/eapropertylist.h \
    ../EventAppShared/eventappshared_global.h \
    ../EventAppShared/eventappshared.h \
    ../EventAppShared/firebase.h \
    ../EventAppShared/eauser.h \
    ../EventAppShared/eaquestion.h \
    ../EventAppShared/eaobjdisplay.h \
    ../EventAppShared/simplecrypt.h \
    ../EventAppShared/eamap.h \
    ../EventAppShared/eastrings.h \
    ../EventAppShared/assistant.h


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

#/media/piers/h/Mobile/Mobile/build-EventApp-Android_for_armeabi_v7a_GCC_4_9_Qt_5_7_0-Debug/android-build/src/org/dreamdev/QtAdMob

android: {
    DISTFILES += \
                $$ANDROID_PACKAGE_SOURCE_DIR/src/org/dreamdev/QtAdMob/QtAdMobActivity.java \
}

contains(ANDROID_TARGET_ARCH, armeabi-v7a) {
  ANDROID_EXTRA_LIBS += ../libs/libssl.so
  ANDROID_EXTRA_LIBS += ../libs/libcrypto.so
}

INCLUDEPATH += $$PWD/../EventAppShared
DEPENDPATH += $$PWD/../EventAppShared

DISTFILES += \
    qml/main.qml \
    qmldir \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

FORMS +=

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_EXTRA_LIBS =
}

contains(ANDROID_TARGET_ARCH,x86) {
    ANDROID_EXTRA_LIBS =
}






