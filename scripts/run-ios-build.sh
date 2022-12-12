#!/bin/bash

TAG="[widget-driver]:"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
TAG_COLOR="\n${GREEN}${TAG}${NC}"

function run_ios_build() {
    echo -e "$TAG_COLOR Building iOS Example app"
    make prepare
    cd widget_driver/example/ios
    pod repo update
    pod install 
    cd ..
    flutter build ios --no-codesign --debug
    echo -e "$TAG_COLOR Example app succesufully built"
}

run_ios_build $@