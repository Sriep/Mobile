REM buildDeployWindows5.9.bat

REM Initilise builds
call C:\"Program Files (x86)\Microsoft Visual Studio 14.0\VC"\vcvarsall.bat amd64

REM Download files from GitHub
REM the MOBIL_DIR needs to be synced with EventOrganiser.iss and EventApp.iss
set MOBILE_DIR=E:\Mobile\Build
set QT_DIR=C:\Qt\5.9\msvc2015_64
set PATH=%QT_DIR%\bin;%PATH%
set QMAKE_MSC_VER=1900
set WINDEPLOYQT_EXE=%QT_DIR%\bin\windeployqt.execd
set OPENSSL64_DIR=C:\OpenSSL-Win64
set INNO_DIR="C:\Program Files (x86)\Inno Setup 5"
REM Clean directoy
del /s /q  %MOBILE_DIR%
rmdir %MOBILE_DIR% /s /q
mkdir %MOBILE_DIR%
cd %MOBILE_DIR%

REM Download from GitHub
git clone https://github.com/Sriep/Mobile.git
cd Mobile
git clone https://github.com/yevgeniy-logachev/QtAdMob.git

REM *********************************************** Build Event Organiser *******************************************
set EVENTORGANOSER_SRCDIR=%MOBILE_DIR%\Mobile\EventOrganiser
set ASSISTANT_SRCDIR=%EVENTORGANOSER_SRCDIR%\Documents

REM Build assistant help files
cd %ASSISTANT_SRCDIR%
del eventApp.qhc
del eventApp.qch
qhelpgenerator eventApp.qhp -o eventApp.qch
qcollectiongenerator eventApp.qhcp -o eventApp.qhc

REM Build Event Organiser

cd %EVENTORGANOSER_SRCDIR%
qmake.exe %EVENTORGANOSER_SRCDIR%\EventOrganiser.pro -spec win32-msvc && C:/Qt/qtcreator-4.3.0/bin/jom.exe qmake_all
jom.exe 
jom.exe clean

REM EventOrganiser deplyment
set EVENTORGANISER_DIR=%EVENTORGANOSER_SRCDIR%\release
set QML_DIR=%EVENTORGANOSER_SRCDIR%
%WINDEPLOYQT_EXE% --qmldir %QML_DIR% %EVENTORGANISER_DIR%\EventOrganiser.exe
cd %OPENSSL64_DIR%
c:
copy /y  *.dll %EVENTORGANISER_DIR%
copy /y  %QT_DIR%\bin\Qt5Location.dll %EVENTORGANISER_DIR%\Qt5Location.dll
xcopy /y  %QT_DIR%\qml\QtWebView %EVENTORGANISER_DIR%\QtWebView\*
xcopy /y  %QT_DIR%\qml\QtWebEngine %EVENTORGANISER_DIR%\QtWebEngine\*
xcopy /y  %QT_DIR%\qml\QtPositioning %EVENTORGANISER_DIR%\QtPositioning\*
xcopy /y  %QT_DIR%\qml\QtLocation %EVENTORGANISER_DIR%\QtLocation\*
xcopy /y  %QT_DIR%\plugins\geoservices %EVENTORGANISER_DIR%\geoservices\*

REM Copy for assistant.exe
mkdir %EVENTORGANISER_DIR%\bin
copy /y  %QT_DIR%\bin\assistant.exe %EVENTORGANISER_DIR%\bin\assistant.exe
copy /y  %QT_DIR%\bin\Qt5Help.dll %EVENTORGANISER_DIR%\bin\Qt5Help.dll
copy /y  %QT_DIR%\bin\Qt5Printsupport.dll %EVENTORGANISER_DIR%\bin\Qt5Printsupport.dll
copy /y  %QT_DIR%\bin\Qt5Widgets.dll %EVENTORGANISER_DIR%\bin\Qt5Widgets.dll
copy /y  %QT_DIR%\bin\Qt5Gui.dll %EVENTORGANISER_DIR%\bin\Qt5Gui.dll
copy /y  %QT_DIR%\bin\Qt5Sql.dll %EVENTORGANISER_DIR%\bin\Qt5Sql.dll
copy /y  %QT_DIR%\bin\Qt5Core.dll %EVENTORGANISER_DIR%\bin\Qt5Core.dll
copy /y  %QT_DIR%\bin\Qt5Network.dll %EVENTORGANISER_DIR%\bin\Qt5Network.dll
copy /y  %QML_DIR%\Documents\eventApp.qhc  %EVENTORGANISER_DIR%\eventApp.qhc

REM Create install files
REM set DEPLOYDIR=C:\Deployment
REM set OUTDIR=%DEPLOYDIR%\EventOrganiser
REM rmdir /s /q %QUTDIR%
cd %INNO_DIR%
iscc /Q %EVENTORGANOSER_SRCDIR%\EventOrganiser.iss


REM *********************************************** Build Event App *******************************************
REM Build Event App
set EVENTAPP_SRCDIR=%MOBILE_DIR%\Mobile\EventApp
cd %EVENTAPP_SRCDIR%
qmake.exe %EVENTAPP_SRCDIR%\EventApp.pro -spec win32-msvc && C:/Qt/qtcreator-4.3.0/bin/jom.exe qmake_all
jom.exe 
jom.exe clean

REM EventOApp deplyment
set EVENTAPP_DIR=%EVENTAPP_SRCDIR%\release
set QML_DIR=%EVENTAPP_SRCDIR%
%WINDEPLOYQT_EXE% --qmldir %QML_DIR% %EVENTAPP_DIR%\EventApp.exe
REM del /s /q %EVENTAPP_DIR%\*.obj
REM del /s /q %EVENTAPP_DIR%\*.cpp
REM del /s /q %EVENTAPP_DIR%\*.h
cd %OPENSSL64_DIR%
c:
copy /y  *.dll %EVENTAPP_DIR%
copy /y  %QT_DIR%\bin\Qt5Location.dll %EVENTAPP_DIR%\Qt5Location.dll
xcopy /y  %QT_DIR%\qml\QtWebView %EVENTAPP_DIR%\QtWebView\*
xcopy /y  %QT_DIR%\qml\QtWebEngine %EVENTAPP_DIR%\QtWebEngine\*
xcopy /y  %QT_DIR%\qml\QtPositioning %EVENTAPP_DIR%\QtPositioning\*
xcopy /y  %QT_DIR%\qml\QtLocation %EVENTAPP_DIR%\QtLocation\*
xcopy /y  %QT_DIR%\plugins\geoservices %EVENTAPP_DIR%\geoservices\*

REM Create install files
cd %INNO_DIR%
iscc /Q %EVENTAPP_SRCDIR%\EventApp.iss
