# += qml quick
QT += network
QT += quick quickcontrols2
QT += qml quick webview
QT += widgets
CONFIG += c++11

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
DEFINES += QTADMOB_QML
include(../QtAdMob/QtAdMob.pri)

#VERSION=1.0.0.0
#DEFINES += APP_VERSION=\\\”$$VERSION\\\”
#GIT_VERSION = $$system(git --git-dir $$PWD/.git --work-tree $$PWD describe --always --tags)
GIT_VERSION = $$system(git describe --always --tags)
DEFINES += GIT_VERSION=\\\"$$GIT_VERSION\\\"

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
INCLUDEPATH += $$PWD/../QtAddMob
DEPENDPATH += $$PWD/../QtAddMob

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

ios {
    QMAKE_INFO_PLIST = ios/Info.plist
}






