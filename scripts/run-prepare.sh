#!/bin/bash

TAG="[widget-driver]:"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
TAG_COLOR="\n${GREEN}${TAG}${NC}"
PROJECT_FOLDERS=("widget_driver" "widget_driver_annotation" "widget_driver_generator" "widget_driver_test")

set -o errexit
set -o nounset
set -o pipefail

function run_prepare() {
    flutter pub get 
}

function fetch_pods() {
    current_dir=$(pwd)
    echo -e "$TAG_COLOR Running pod install"
    cd "widget_driver/example/ios"
    pod repo update
    pod install
    cd $current_dir
}

if [[ $# -eq 0 ]] 
    then
        echo -e "$TAG_COLOR Preparing project"
        for project_folder in "${PROJECT_FOLDERS[@]}"
        do
            echo -e "$TAG_COLOR Preparing: $project_folder"
            cd $project_folder
            run_prepare $project_folder
            cd ..
        done
        fetch_pods $@
       
else
    project_folder=$1
    echo -e "\n$TAG_COLOR Preparing project: $project_folder"
    cd $project_folder
    run_flutter_lint $project_folder
fi

