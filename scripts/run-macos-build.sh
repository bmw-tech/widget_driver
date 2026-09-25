#!/bin/bash

TAG="[widget-driver]:"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
TAG_COLOR="\n${GREEN}${TAG}${NC}"

function run_macos_build() {
    echo -e "$TAG_COLOR Building macOS Example app"
    make install
    cd widget_driver/example
    flutter build macos --debug --no-tree-shake-icons $1
    echo -e "$TAG_COLOR Example app succesufully built"
}

run_macos_build $@
