REM buildwindows.bat
REM Download files from GitHub
set MOBILE_DIR=E:\Mobile\build
set QT_DIR=C:\Qt\5.9\msvc2015_64
set PATH=%QT_DIR%\bin;%PATH%
set QMAKE_MSC_VER=1900
e:
REM Clean directoy
rmdir %MOBILE_DIR% /s /q
del /s /q  %MOBILE_DIR%
mkdir %MOBILE_DIR%
cd %MOBILE_DIR%
REM Download from GitHub
git clone https://github.com/Sriep/Mobile.git
cd Mobile
git clone https://github.com/yevgeniy-logachev/QtAdMob.git

REM Build Event App
set EVENTAPP_SRCDIR=%MOBILE_DIR%\Mobile\EventApp
cd %EVENTAPP_SRCDIR%
REM mkdir %MOBILE_DIR%\Mobile\build-EventOrganiser-Desktop_Qt_5_8_0_MSVC2015_64bit-Release
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
REM qmake.exe %EVENTAPP_SRCDIR%\EventOrganiser.pro -spec win32-msvc && C:/Qt/qtcreator-4.3.0/bin/jom.exe qmake_all
qmake.exe %EVENTAPP_SRCDIR%\EventApp.pro -spec win32-msvc && C:/Qt/qtcreator-4.3.0/bin/jom.exe qmake_all
jom.exe 
jom.exe clean

REM buildwindows.bat
set MOBILE_DIR=E:\Mobile\Mobile
set QT_DIR=C:\Qt\5.9\msvc2015_64
set WINDEPLOYQT_EXE=%QT_DIR%\bin\windeployqt.exe
set OPENSSL64_DIR=C:\OpenSSL-Win64
REM EventOrganiser deplyment
REM set EVENTAPP_DIR=E:\Mobile\Mobile\build-EventOrganiser-Desktop_Qt_5_9_0_MSVC2015_64bit-Release\release
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
set INNO_DIR="C:\Program Files (x86)\Inno Setup 5"
set DEPLOYDIR=C:\Deployment
set OUTDIR=%DEPLOYDIR%\EventApp
set EO_ISS_FILE=EventApp.iss
REM rmdir /s /q %QUTDIR%
cd %INNO_DIR%
iscc /Q %MOBILE_DIR%\Deploy\%EO_ISS_FILE%
