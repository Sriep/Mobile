REM buildwindows.bat

set MOBILE_DIR=E:\Mobile\Mobile
REM set QT_DIR=C:\Qt\5.8\msvc2015_64
set QT_DIR=C:\Qt\5.9\msvc2015_64
set WINDEPLOYQT_EXE=%QT_DIR%\bin\windeployqt.exe
set OPENSSL64_DIR=C:\OpenSSL-Win64

REM EventOrganiser deplyment
set EVENTORGANISER_DIR=E:\Mobile\Mobile\build-EventOrganiser-Desktop_Qt_5_9_0_MSVC2015_64bit-Release\release
set QML_DIR=E:\Mobile\Mobile\EventOrganiser

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

REM Event App deployment
set EVENTAPP_DIR=E:\Mobile\Mobile\build-EventApp-Desktop_Qt_5_9_0_MSVC2015_64bit-Release\release
set QML_DIR=E:\Mobile\Mobile\EventApp

%WINDEPLOYQT_EXE% --qmldir %QML_DIR% %EVENTAPP_DIR%\EventApp.exe
del /s /q %EVENTAPP_DIR%\*.obj
del /s /q %EVENTAPP_DIR%\*.cpp
del /s /q %EVENTAPP_DIR%\*.h

cd %OPENSSL64_DIR%
c:
copy /y  *.dll %EVENTAPP_DIR%
copy /y  %QT_DIR%\bin\Qt5Location.dll %EVENTAPP_DIR%\Qt5Location.dll
xcopy /y  %QT_DIR%\qml\QtWebView %EVENTAPP_DIR%\QtWebView\*
xcopy /y %QT_DIR%\qml\QtWebEngine %EVENTAPP_DIR%\QtWebEngine\*
xcopy /y  %QT_DIR%\qml\QtPositioning %EVENTAPP_DIR%\QtPositioning\*
xcopy /y  %QT_DIR%\qml\QtLocation %EVENTAPP_DIR%\QtLocation\*
xcopy /y  %QT_DIR%\plugins\geoservices %EVENTAPP_DIR%\geoservices\*
set INNO_DIR="C:\Program Files (x86)\Inno Setup 5"
set DEPLOYDIR=C:\Deployment
set OUTDIR=%DEPLOYDIR%\EventApp
set EA_ISS_FILE=EventApp.iss

REM rmdir /s /q %QUTDIR%

cd %INNO_DIR%
iscc /Q %MOBILE_DIR%\Deploy\%EA_ISS_FILE%
