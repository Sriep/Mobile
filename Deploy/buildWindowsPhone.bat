REM buildwindowsPhone.bat

REM Download files from GitHub
e:
set WINDOWS_BUILD_DIR=E:\Mobile\Build
mkdir %WINDOWS_BUILD_DIR%
cd %WINDOWS_BUILD_DIR%
git clone https://github.com/Sriep/Mobile.git
cd Mobile
git clone https://github.com/yevgeniy-logachev/QtAdMob.git

REM Configure for Visual Studio
cd EventApp
qmake.exe -tp vc CONFIG+=windeployqt

REM buildwindowsPhone
qmake.exe %WINDOWS_BUILD_DIR%\Mobile\EventApp\EventApp.pro -spec winrt-x64-msvc2015 && C:/Qt/Tools/QtCreator/bin/jom.exe qmake_all
jom.exe in %WINDOWS_BUILD_DIR%\Mobile\build-EventApp-Qt_5_8_0_for_Windows_Runtime_64bit-Release
jom.exe clean in %WINDOWS_BUILD_DIR%\Mobile\build-EventApp-Qt_5_8_0_for_Windows_Runtime_64bit-Release

REM winrtrunner
winrtrunner