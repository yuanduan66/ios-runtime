#!/usr/bin/env bash

set -e

source "$(dirname "$0")/common.sh"

checkpoint "Building TKLiveSync.framework"

pushd "$WORKSPACE/plugins/TKLiveSync"

rm -rf "build"

xcodebuild \
    -configuration "Release" \
    -sdk "iphonesimulator" \
    build \
    CONFIGURATION_BUILD_DIR="$(pwd)/build/Release-iphonesimulator" \
    ARCHS="i386 x86_64" VALID_ARCHS="i386 x86_64" \
    -quiet

xcodebuild \
    -configuration "Release" \
    -sdk "iphoneos" \
    build \
    CONFIGURATION_BUILD_DIR="$(pwd)/build/Release-iphoneos" \
    ARCHS="armv7 arm64" VALID_ARCHS="armv7 arm64" \
    -quiet

checkpoint "Packaging TKLiveSync.framework"
mkdir -p "$WORKSPACE/dist"
cp -r "build/Release-iphoneos/TKLiveSync.framework" "$WORKSPACE/dist"
rm "$WORKSPACE/dist/TKLiveSync.framework/TKLiveSync"
lipo -create -output "$WORKSPACE/dist/TKLiveSync.framework/TKLiveSync" \
    "build/Release-iphonesimulator/TKLiveSync.framework/TKLiveSync" \
    "build/Release-iphoneos/TKLiveSync.framework/TKLiveSync"

popd
checkpoint "Finished building TKLiveSync - $WORKSPACE/dist/TKLiveSync.framework"
