REM buildwindows.bat

set MOBILE_DIR=E:\Mobile\Mobile
REM set QT_DIR=C:\Qt\5.8\msvc2015_64
set QT_DIR=C:\Qt\5.9\msvc2015_64
set WINDEPLOYQT_EXE=%QT_DIR%\bin\windeployqt.exe
set OPENSSL64_DIR=C:\OpenSSL-Win64

REM EventOrganiser deplyment
set EVENTORGANISER_DIR=E:\Mobile\Mobile\build-EventOrganiser-Desktop_Qt_5_9_0_MSVC2015_64bit-Release\release
set QML_DIR=E:\Mobile\Mobile\EventOrganiser

REM %WINDEPLOYQT_EXE% --qmldir %QML_DIR% %EVENTORGANISER_DIR%\EventOrganiser.exe
del /s /q %EVENTORGANISER_DIR%\*.obj
del /s /q %EVENTORGANISER_DIR%\*.cpp
del /s /q %EVENTORGANISER_DIR%\*.h

cd %OPENSSL64_DIR%
c:
copy /y  *.dll %EVENTORGANISER_DIR%
copy /y  %QT_DIR%\bin\Qt5Location.dll %EVENTORGANISER_DIR%\Qt5Location.dll
xcopy /y  %QT_DIR%\qml\QtWebView      %EVENTORGANISER_DIR%\QtWebView\*
xcopy /y  %QT_DIR%\qml\QtWebEngine    %EVENTORGANISER_DIR%\QtWebEngine\*
xcopy /y  %QT_DIR%\qml\QtPositioning  %EVENTORGANISER_DIR%\QtPositioning\*
xcopy /y  %QT_DIR%\qml\QtLocation     %EVENTORGANISER_DIR%\QtLocation\*
xcopy /y  %QT_DIR%\plugins\geoservices %EVENTORGANISER_DIR%\geoservices\*
xcopy /y  %QT_DIR%\plugins\translations %EVENTORGANISER_DIR%\translations\*
xcopy /y  %QT_DIR%\plugins\resources   %EVENTORGANISER_DIR%\resources\*

mkdir %EVENTORGANISER_DIR%\bearer
xcopy /y  %QT_DIR%\plugins\bearer\*.dll %EVENTORGANISER_DIR%\bearer\*
mkdir %EVENTORGANISER_DIR%\iconengines
xcopy /y  %QT_DIR%\plugins\iconengines\*.dll %EVENTORGANISER_DIR%\iconengines\*
mkdir %EVENTORGANISER_DIR%\imageformats
xcopy /y  %QT_DIR%\plugins\imageformats\*.dll %EVENTORGANISER_DIR%\imageformats\*
mkdir %EVENTORGANISER_DIR%\platforminputcontexts
xcopy /y  %QT_DIR%\plugins\platforminputcontexts\*.dll %EVENTORGANISER_DIR%\platforminputcontexts\*
mkdir %EVENTORGANISER_DIR%\platforms
xcopy /y  %QT_DIR%\plugins\platforms\*.dll %EVENTORGANISER_DIR%\platforms\*
mkdir %EVENTORGANISER_DIR%\position
xcopy /y  %QT_DIR%\plugins\position\*.dll %EVENTORGANISER_DIR%\position\*
mkdir %EVENTORGANISER_DIR%\qmltooling
xcopy /y  %QT_DIR%\plugins\qmltooling\*.dll %EVENTORGANISER_DIR%\qmltooling\*
mkdir %EVENTORGANISER_DIR%\scenegraph
xcopy /y  %QT_DIR%\plugins\scenegraph\*.dll %EVENTORGANISER_DIR%\scenegraph\*

xcopy /y  %QT_DIR%\qml\Qt\labs %EVENTORGANISER_DIR%\Qt\labs\*
xcopy /y  %QT_DIR%\qml\QtGraphicalEffects\private %EVENTORGANISER_DIR%\QtGraphicalEffects\private\*
xcopy /y  %QT_DIR%\qml\QtQml\Models.2 %EVENTORGANISER_DIR%\QtQml\Models.2\*
xcopy /y  %QT_DIR%\qml\QtQuick %EVENTORGANISER_DIR%\QtQuick\*
xcopy /y  %QT_DIR%\qml\QtQuick.2 %EVENTORGANISER_DIR%\QtQuick.2\*


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

copy /y  %QT_DIR%\bin\D3Dcompiler_47.dll %EVENTORGANISER_DIR%\D3Dcompiler_47.dll
copy /y  %QT_DIR%\bin\libeay32.dll %EVENTORGANISER_DIR%\libeay32.dll
copy /y  %QT_DIR%\bin\libEGL.dll %EVENTORGANISER_DIR%\libEGL.dll
copy /y  %QT_DIR%\bin\libGLESV2.dll %EVENTORGANISER_DIR%\libGLESV2.dll
copy /y  %QT_DIR%\bin\libssl32.dll %EVENTORGANISER_DIR%\libssl32.dll
copy /y  %QT_DIR%\bin\opengl32sw.dll %EVENTORGANISER_DIR%\opengl32sw.dll
copy /y  %QT_DIR%\bin\Qt5Core.dll %EVENTORGANISER_DIR%\Qt5Core.dll
copy /y  %QT_DIR%\bin\Qt5Gui.dll %EVENTORGANISER_DIR%\Qt5Gui.dll
copy /y  %QT_DIR%\bin\Qt5Network.dll %EVENTORGANISER_DIR%\Qt5Network.dll
copy /y  %QT_DIR%\bin\Qt5Positioning.dll %EVENTORGANISER_DIR%\Qt5Positioning.dll
copy /y  %QT_DIR%\bin\Qt5Qml.dll %EVENTORGANISER_DIR%\Qt5Qml.dll
copy /y  %QT_DIR%\bin\Qt5Quick.dll %EVENTORGANISER_DIR%\Qt5Quick.dll
copy /y  %QT_DIR%\bin\Qt5QuickControls2.dll %EVENTORGANISER_DIR%\Qt5QuickControls2.dll
copy /y  %QT_DIR%\bin\Qt5QuickTemplates2.dll %EVENTORGANISER_DIR%\Qt5QuickTemplates2.dll
copy /y  %QT_DIR%\bin\Qt5SerialPort.dll %EVENTORGANISER_DIR%\Qt5SerialPort.dll
copy /y  %QT_DIR%\bin\Qt5Svg.dll %EVENTORGANISER_DIR%\Qt5Svg.dll
copy /y  %QT_DIR%\bin\Qt5WebChannel.dll %EVENTORGANISER_DIR%\Qt5WebChannel.dll
copy /y  %QT_DIR%\bin\Qt5WebEngine.dll %EVENTORGANISER_DIR%\Qt5WebEngine.dll
copy /y  %QT_DIR%\bin\Qt5WebEngineCore.dll %EVENTORGANISER_DIR%\Qt5WebEngineCore.dll
copy /y  %QT_DIR%\bin\Qt5WebView.dll %EVENTORGANISER_DIR%\Qt5WebView.dll
copy /y  %QT_DIR%\bin\Qt5Widgets.dll %EVENTORGANISER_DIR%\Qt5Widgets.dll
copy /y  %QT_DIR%\bin\QtWebEngineProcess.exe %EVENTORGANISER_DIR%\QtWebEngineProcess.exe

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
