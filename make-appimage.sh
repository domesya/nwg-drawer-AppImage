#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q nwg-drawer | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://github.com/nwg-piotr/nwg-drawer/assets/20579136/1a7578e8-5332-4e4c-bdce-9b9bf875c0e7
export DESKTOP=DUMMY
export MAIN_BIN=nwg-drawer
export URUNTIME_PRELOAD=1

# Deploy dependencies
quick-sharun \
  /usr/bin/nwg-drawer

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
