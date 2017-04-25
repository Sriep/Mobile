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


RESOURCES += qml.qrc \
   qmlShared.qrc
#RESOURCES += qmlShared.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

win32 {
  #  DEFINES += "GIT_EXE=\"\\\"C:\\\Program Files\\\Git\\\bin\\\git.exe\\\"\""
}

win64 {
  #  DEFINES += "GIT_EXE=\"\\\"C:\\\Program Files\\\Git\\\bin\\\git.exe\\\"\""
}

macx {
   # message(macx)
}

unix:!macx{
   # DEFINES += "GIT_EXE=\"\\\"/usr/bin/git\\\"\""
   # message(unix)
   # GIT_VERSION = $$system(git describe --always --tags)
   # DEFINES += "GIT_VERSION=\"\\\"$$GIT_VERSION\\\"\""
}

android: {
    DISTFILES += \
                $$ANDROID_PACKAGE_SOURCE_DIR/src/org/dreamdev/QtAdMob/QtAdMobActivity.java \
}

ios {
    QMAKE_INFO_PLIST = ios/Info.plist
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
    android/gradlew.bat \
    android/main.qml

FORMS +=

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_EXTRA_LIBS =
}

contains(ANDROID_TARGET_ARCH,x86) {
    ANDROID_EXTRA_LIBS =
}

#https://www.everythingfrontend.com/posts/app-version-from-git-tag-in-qt-qml.html
GIT_VERSION_LONG = $$system(git describe --always --tags)
DEFINES += GIT_VERSION_LONG=\\\"$$GIT_VERSION_LONG\\\"
GIT_VERSION = $$system(git describe --tags)
DEFINES += GIT_VERSION=\\\"$$GIT_VERSION\\\"
VERSION = $$GIT_VERSION
message(versionName from github: $$GIT_VERSION)
message(long versionName from github: $$GIT_VERSION_LONG)

#http://www.cutehacks.com/blog/2015/5/28/one-version-number-to-rule-them-all
VERSIONS_ARR = $$split(GIT_VERSION, .)
VERSION_MAJ = $$member(VERSIONS_ARR, 0)
VERSION_MIN = $$member(VERSIONS_ARR, 1)
VERSION_PAT = $$member(VERSIONS_ARR, 2)

message(Major $$VERSION_MAJ Minor $$VERSION_MIN Patch $$VERSION_PAT)

android {
#http://www.cutehacks.com/blog/2015/5/28/one-version-number-to-rule-them-all
    QT_varfile = ""
    for(var, $$list($$find($$list($$enumerate_vars()), ^(?!QMAKE_.*|QT\..*|QT_.*|\.QMAKE.*).*$))) {
        line = $$var "$$eval($$var)"
        QT_varfile += $$join(line, "=")
    }
    write_file($$absolute_path("VARIABLES.txt", $$OUT_PWD), QT_varfile)
}





