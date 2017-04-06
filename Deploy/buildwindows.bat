REM buildwindows.bat

set MOBILE_DIR=E:\Mobile\Mobile
set WINDEPLOYQT_EXE=C:\Qt\5.8\msvc2015_64\bin\windeployqt.exe
set EVENTORGANISER_DIR=E:\Mobile\Mobile\build-EventOrganiser-Desktop_Qt_5_8_0_MSVC2015_64bit-Release\release
set QML_DIR=E:\Mobile\Mobile\EventOrganiser
set OPENSSL64_DIR=C:\OpenSSL-Win64

%WINDEPLOYQT_EXE% --qmldir %QML_DIR% %EVENTORGANISER_DIR%\EventOrganiser.exe
del /s /q %EVENTORGANISER_DIR%\*.obj
del /s /q %EVENTORGANISER_DIR%\*.cpp

cd %OPENSSL64_DIR%
c:
copy *.dll %EVENTORGANISER_DIR%

set INNO_DIR="C:\Program Files (x86)\Inno Setup 5"
set DEPLOYDIR=C:\Deployment
set OUTDIR=%DEPLOYDIR%\EventOrganiser
set ISS_FILE=EventOrganiser.iss

REM rmdir /s /q %QUTDIR%

cd %INNO_DIR%
iscc /Q %MOBILE_DIR%/Deploy/%ISS_FILE%
