#!/bin/bash

TAG="[widget-driver]:"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
TAG_COLOR="\n${GREEN}${TAG}${NC}"
PROJECT_FOLDERS=("widget_driver" "widget_driver_generator" "widget_driver_test")

function run_tests() {
    current_dir=$(pwd)
    cd $1
    flutter pub get
    flutter test --coverage --no-pub --no-test-assets --no-track-widget-creation --no-sound-null-safety || exit $?
    cd $current_dir
}

if [[ $# -eq 0 ]] 
    then
        echo -e "$TAG_COLOR Preparing project"
        for project_folder in "${PROJECT_FOLDERS[@]}"
        do
            echo -e "$TAG_COLOR Preparing: $project_folder"
            run_tests $project_folder
        done
       
else
    echo -e "\n$TAG_COLOR Running lint inside: $project_folder"
    cd $project_folder
    run_tests $project_folder
fi

