REM buildwindows.bat
REM Download files from GitHub
set MOBILE_DIR=E:\Mobile\build
set QT_DIR=C:\Qt\5.9\msvc2015_64
set PATH=%QT_DIR%\bin;%PATH%
set QMAKE_MSC_VER=1900
set EVENTORGANOSER_SRCDIR=%MOBILE_DIR%\Mobile\EventOrganiser
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

E:\Mobile\Mobile\Deploy\2.bat
