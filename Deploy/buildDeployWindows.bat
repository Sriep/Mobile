REM buildwindows.bat
REM Download files from GitHub

set MOBILE_DIR=E:\Mobile\build

REM Download from GitHub
e:
mkdir %MOBILE_DIR%
cd %MOBILE_DIR%
git clone https://github.com/Sriep/Mobile.git
cd Mobile
git clone https://github.com/yevgeniy-logachev/QtAdMob.git

cd %MOBILE_DIR%\Mobile\EventOrganiser
mkdir %MOBILE_DIR%\Mobile\build-EventOrganiser-Desktop_Qt_5_8_0_MSVC2015_64bit-Release
qmake.exe %MOBILE_DIR%\Mobile\EventOrganiser\EventOrganiser.pro -spec win32-msvc2015 && C:/Qt/Tools/QtCreator/bin/jom.exe qmake_all
jom.exe in %MOBILE_DIR%\Mobile\build-EventOrganiser-Desktop_Qt_5_8_0_MSVC2015_64bit-Release
jom.exe clean in %MOBILE_DIR%\Mobile\build-EventOrganiser-Desktop_Qt_5_8_0_MSVC2015_64bit-Release


qmake.exe E:\Mobile\build\Mobile\EventOrganiser\EventOrganiser.pro -spec win32-msvc2015 && C:/Qt/Tools/QtCreator/bin/jom.exe qmake_all
jom.exe in E:\Mobile\build\Mobile\build-EventOrganiser-Desktop_Qt_5_8_0_MSVC2015_64bit-Release
jom.exe clean in E:\Mobile\build\Mobile\build-EventOrganiser-Desktop_Qt_5_8_0_MSVC2015_64bit-Release





set MOBILE_DIR=E:\Mobile\Mobile
set WINDEPLOYQT_EXE=C:\Qt\5.8\msvc2015_64\bin\windeployqt.exe
set EVENTORGANISER_DIR=%MOBILE_DIR%\build-EventOrganiser-Desktop_Qt_5_8_0_MSVC2015_64bit-Release\release
set QML_DIR=%MOBILE_DIR%\EventOrganiser
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
