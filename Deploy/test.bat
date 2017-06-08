echo before
call C:\"Program Files (x86)\Microsoft Visual Studio 14.0\VC"\vcvarsall.bat amd64
echo after
REM Download files from GitHub
set MOBILE_DIR=E:\Mobile\Build
set QT_DIR=C:\Qt\5.9\msvc2015_64
set PATH=%QT_DIR%\bin;%PATH%
set QMAKE_MSC_VER=1900
set WINDEPLOYQT_EXE=%QT_DIR%\bin\windeployqt.execd
set OPENSSL64_DIR=C:\OpenSSL-Win64