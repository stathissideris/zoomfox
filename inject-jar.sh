#!/bin/bash
#point this script to the dir where zoomFox is already installed
#the jar will be made and copied there
#then click on "Reload All Chrome" (Extension Developer's Extension)
mkdir make-dir
cd src
zip ../make-dir/zoomFox.jar content/*
cd ../make-dir/
mkdir chrome
mv zoomFox.jar $1
rm -rf make-dir
rm -rf chrome
