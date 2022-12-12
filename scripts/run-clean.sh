#!/bin/bash
TAG="[widget-driver]:"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
TAG_COLOR="\n${GREEN}${TAG}${NC}"
set -o errexit
set -o nounset
set -o pipefail

function run_flutter_clean() {
    current_dir=$(pwd)
    echo -e "$TAG_COLOR Running flutter clean inside $1"
    cd $1
    flutter clean
    cd $current_dir
}

run_flutter_clean "widget_driver"
run_flutter_clean "widget_driver_annotation"
run_flutter_clean "widget_driver_generator"
run_flutter_clean "widget_driver_test"