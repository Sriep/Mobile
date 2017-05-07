#!/bin/bash

#Deployment
MACDEPLOYQT=/Users/piers/Qt/5.8/clang_64/bin/macdeployqt

#Deploy Event Organiser
EVENTORGANISER_DIR=/Users/piers/Mobile/build-EventOrganiser-Desktop_Qt_5_8_0_clang_64bit-Release
QML_DIR=/Users/piers/Mobile/EventOrganiser
$MACDEPLOYQT $EVENTORGANISER_DIR -qmldir=$QML_DIR 

#Deploy Event App
EVENTAPP_DIR=/Users/piers/Mobile/build-EventApp-Desktop_Qt_5_8_0_clang_64bit-Release
QML_DIR=/Users/piers/Mobile/EventApp
$MACDEPLOYQT $EVENTAPP_DIR -qmldir=$QML_DIR 