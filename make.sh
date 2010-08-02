#!/bin/bash
VERSION="0.8.1"
TARGET="zoomfox_$VERSION.xpi"
echo $TARGET

rm $TARGET
mkdir make-dir
cd src
zip ../make-dir/zoomFox.jar content/*
cd ../make-dir/
mkdir chrome
mv zoomFox.jar chrome
cp ../src/install.rdf .
cp ../src/chrome.manifest .
zip -r $TARGET *
mv $TARGET ..
cd ..
rm -rf make-dir
