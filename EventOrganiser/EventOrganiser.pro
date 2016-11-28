#QT += qml quick
QT += quick quickcontrols2
CONFIG += c++11

SOURCES += main.cpp \
    ../EventAppShared/eacontainer.cpp \
    ../EventAppShared/eaconstruction.cpp \
    ../EventAppShared/eainfo.cpp \
    ../EventAppShared/httpdownload.cpp \
    ../EventAppShared/csv.cpp \
    ../EventAppShared/eaitemlist.cpp

HEADERS += \
    ../EventAppShared/eainfo.h \
    ../EventAppShared/eacontainer.h \
    ../EventAppShared/eaconstruction.h \
    ../EventAppShared/httpdownload.h \
    ../EventAppShared/eventappshared_global.h \
    ../EventAppShared/csv.h \
    ../EventAppShared/eaitemlist.h

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

#unix:!macx: LIBS += -L$$PWD/../build-EventAppShared-Desktop_Qt_5_7_0_GCC_64bit-Debug/ -lEventAppShared

INCLUDEPATH += $$PWD/../EventAppShared
DEPENDPATH += $$PWD/../EventAppShared

DISTFILES += \
    WelcomeTabForm.ui.qml \
    EventOrganiser.pro.user \
    content/EAInfoThemeForm.ui.qml \
    content/EAInfoNameForm.ui.qml \
    EAInfoPageForm.ui.qml \
    MainStackForm.ui.qml \
    EAConstructionPageForm.ui.qml \
    content/EAListDisplayPageForm.ui.qml \
    content/TitleFieldListDelegate.qml \
    content/TitleFieldListDelegateForm.ui.qml \
    content/DataListDelegateForm.ui.qml \
    content/FormatList.qml \
    content/FormatListForm.ui.qml \
    content/FormatTextDelegate.qml \
    content/InListCheckDelegate.qml
