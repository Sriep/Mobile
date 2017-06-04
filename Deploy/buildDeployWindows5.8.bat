REM buildwindows.bat
REM Download files from GitHub

set MOBILE_DIR=E:\Mobile\build
set QT_DIR=C:\Qt\5.8\msvc2015_64
set PATH=%QT_DIR%\bin;%PATH%
set QMAKE_MSC_VER=1900
set EVENT_ORGAINSER_SRC=%MOBILE_DIR%\Mobile\EventOrganiser
REM Download from GitHub
e:
deltree  %MOBILE_DIR% /s /q
del /s /q  %MOBILE_DIR%
rmdir /q /s %MOBILE_DIR%


mkdir %MOBILE_DIR%
cd %MOBILE_DIR%
git clone https://github.com/Sriep/Mobile.git
cd Mobile
git clone https://github.com/yevgeniy-logachev/QtAdMob.git
REM Build project
cd %EVENT_ORGAINSER_SRC%
REM mkdir %MOBILE_DIR%\Mobile\build-EventOrganiser-Desktop_Qt_5_8_0_MSVC2015_64bit-Release
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
qmake.exe %EVENT_ORGAINSER_SRC%\EventOrganiser.pro -spec win32-msvc && C:/Qt/qtcreator-4.3.0/bin/jom.exe qmake_all
jom.exe
jom.exe clean
REM jom.exe in %MOBILE_DIR%\Mobile\build-EventOrganiser-Desktop_Qt_5_8_0_MSVC2015_64bit-Release
REM jom.exe clean in %MOBILE_DIR%\Mobile\build-EventOrganiser-Desktop_Qt_5_8_0_MSVC2015_64bit-Release









REM buildwindows.bat

REM set MOBILE_DIR=E:\Mobile\Mobile
set QT_DIR=C:\Qt\5.8\msvc2015_64
REM set QT_DIR=C:\Qt\5.9\msvc2015_64
set WINDEPLOYQT_EXE=%QT_DIR%\bin\windeployqt.exe
set OPENSSL64_DIR=C:\OpenSSL-Win64

REM EventOrganiser deplyment
REM set EVENTORGANISER_DIR=E:\Mobile\Mobile\build-EventOrganiser-Desktop_Qt_5_8_0_MSVC2015_64bit-Release\release
set EVENTORGANISER_DIR=%EVENT_ORGAINSER_SRC%\release
set QML_DIR=%MOBILE_DIR%\Mobile\EventOrganiser

%WINDEPLOYQT_EXE% --qmldir %QML_DIR% %EVENTORGANISER_DIR%\EventOrganiser.exe
del /s /q %EVENTORGANISER_DIR%\*.obj
del /s /q %EVENTORGANISER_DIR%\*.cpp
del /s /q %EVENTORGANISER_DIR%\*.h

cd %OPENSSL64_DIR%
c:
copy /y  *.dll %EVENTORGANISER_DIR%
copy /y  %QT_DIR%\bin\Qt5Location.dll %EVENTORGANISER_DIR%\Qt5Location.dll
xcopy /y  %QT_DIR%\qml\QtWebView %EVENTORGANISER_DIR%\QtWebView\*
xcopy /y  %QT_DIR%\qml\QtWebEngine %EVENTORGANISER_DIR%\QtWebEngine\*
xcopy /y  %QT_DIR%\qml\QtPositioning %EVENTORGANISER_DIR%\QtPositioning\*
xcopy /y  %QT_DIR%\qml\QtLocation %EVENTORGANISER_DIR%\QtLocation\*
xcopy /y  %QT_DIR%\plugins\geoservices %EVENTORGANISER_DIR%\geoservices\*

REM Copy for asssistant
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
set INNO_DIR="C:\Program Files (x86)\Inno Setup 5"
set DEPLOYDIR=C:\Deployment
set OUTDIR=%DEPLOYDIR%\EventOrganiser
set EO_ISS_FILE=EventOrganiser.iss

REM rmdir /s /q %QUTDIR%
cd %INNO_DIR%
iscc /Q %MOBILE_DIR%\Deploy\%EO_ISS_FILE%

