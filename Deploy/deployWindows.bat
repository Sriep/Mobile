REM buildwindows.bat

set MOBILE_DIR=E:\Mobile\Mobile
set QT_DIR=C:\Qt\5.8\msvc2015_64

REM EventOrganiser deplyment
set WINDEPLOYQT_EXE=C:\Qt\5.8\msvc2015_64\bin\windeployqt.exe
set EVENTORGANISER_DIR=E:\Mobile\Mobile\build-EventOrganiser-Desktop_Qt_5_8_0_MSVC2015_64bit-Release\release
set QML_DIR=E:\Mobile\Mobile\EventOrganiser
set OPENSSL64_DIR=C:\OpenSSL-Win64

%WINDEPLOYQT_EXE% --qmldir %QML_DIR% %EVENTORGANISER_DIR%\EventOrganiser.exe
del /s /q %EVENTORGANISER_DIR%\*.obj
del /s /q %EVENTORGANISER_DIR%\*.cpp
del /s /q %EVENTORGANISER_DIR%\*.h

cd %OPENSSL64_DIR%
c:
copy *.dll %EVENTORGANISER_DIR%
copy %QT_DIR%\bin\Qt5Location.dll %EVENTORGANISER_DIR%\Qt5Location.dll
xcopy %QT_DIR%\qml\QtWebView %EVENTORGANISER_DIR%\QtWebView\*
xcopy %QT_DIR%\qml\QtWebEngine %EVENTORGANISER_DIR%\QtWebEngine\*
xcopy %QT_DIR%\qml\QtPositioning %EVENTORGANISER_DIR%\QtPositioning\*
xcopy %QT_DIR%\qml\QtLocation %EVENTORGANISER_DIR%\QtLocation\*
xcopy %QT_DIR%\plugins\geoservices %EVENTORGANISER_DIR%\geoservices\*

set INNO_DIR="C:\Program Files (x86)\Inno Setup 5"
set DEPLOYDIR=C:\Deployment
set OUTDIR=%DEPLOYDIR%\EventOrganiser
set EO_ISS_FILE=EventOrganiser.iss

REM rmdir /s /q %QUTDIR%

cd %INNO_DIR%
iscc /Q %MOBILE_DIR%/Deploy/%EO_ISS_FILE%

REM Event App deployment
set WINDEPLOYQT_EXE=C:\Qt\5.8\msvc2015_64\bin\windeployqt.exe
set EVENTAPP_DIR=E:\Mobile\Mobile\build-EventApp-Desktop_Qt_5_8_0_MSVC2015_64bit-Release\release
set QML_DIR=E:\Mobile\Mobile\EventApp
set OPENSSL64_DIR=C:\OpenSSL-Win64

%WINDEPLOYQT_EXE% --qmldir %QML_DIR% %EVENTAPP_DIR%\EventAppexe
del /s /q %EVENTAPP_DIR%\*.obj
del /s /q %EVENTAPP_DIR%\*.cpp

cd %OPENSSL64_DIR%
c:
copy *.dll %EVENTAPP_DIR%
copy %QT_DIR%\bin\Qt5Location.dll %EVENTAPP_DIR%\Qt5Location.dll
xcopy %QT_DIR%\qml\QtWebView %EVENTAPP_DIR%\QtWebView\*
xcopy %QT_DIR%\qml\QtWebEngine %EVENTAPP_DIR%\QtWebEngine\*
xcopy %QT_DIR%\qml\QtPositioning %EVENTAPP_DIR%\QtPositioning\*
xcopy %QT_DIR%\qml\QtLocation %EVENTAPP_DIR%\QtLocation\*
xcopy %QT_DIR%\plugins\geoservices %EVENTAPP_DIR%\geoservices\*

set INNO_DIR="C:\Program Files (x86)\Inno Setup 5"
set DEPLOYDIR=C:\Deployment
set OUTDIR=%DEPLOYDIR%\EventApp
set EA_ISS_FILE=EventApp.iss

REM rmdir /s /q %QUTDIR%

cd %INNO_DIR%
iscc /Q %MOBILE_DIR%/Deploy/%EA_ISS_FILE%
