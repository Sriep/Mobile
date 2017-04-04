#!/bin/bash

MACDEPLOYQT=/Users/piers/Qt/5.8/clang_64/bin/macdeployqt
EVENTORGANISER_DIR=/Users/piers/Mobile/build-EventOrganiser-Desktop_Qt_5_8_0_clang_64bit-Release
QML_DIR=/Users/piers/Mobile/EventOrganiser       
                   
$MACDEPLOYQT $EVENTORGANISER_DIR -qmldir=$QML_DIR 