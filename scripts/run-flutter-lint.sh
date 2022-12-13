#!/bin/bash

TAG="[widget-driver]:"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
TAG_COLOR="\n${GREEN}${TAG}${NC}"
TAG_ERROR_COLOR="\n${RED}${TAG}${NC}"

PROJECT_FOLDERS=("widget_driver" "widget_driver_annotation" "widget_driver_generator" "widget_driver_test")

set -o errexit
set -o nounset
set -o pipefail

function run_flutter_lint() {
    echo -e "$TAG_COLOR Running Flutter analyzer"
    flutter analyze --no-congratulate || exit $?

    if [ "$1" == "--no-exit" ]; then
        echo -e "$TAG_COLOR Running Dart formatter - No exit \n"
        dart format . -l 120 || exit $?
    else
        echo -e "$TAG_COLOR Running Dart formatter - Set Exit \n"
        dart format . --set-exit-if-changed -l 120 || exit $?
    fi
}

if [[ $# -eq 0 ]] 
    then
        echo -e "$TAG Running lint inside all project folders"
        for project_folder in "${PROJECT_FOLDERS[@]}"
        do
            echo -e "$TAG_COLOR Running lint inside: $project_folder"
            cd $project_folder
            run_flutter_lint $project_folder
            cd ..
        done
else
    project_folder=$1
    if [ -d "$project_folder" ]; then
        echo -e "\n$TAG_COLOR Running lint inside: $project_folder"
        cd $project_folder
        run_flutter_lint $project_folder
    else
        echo -e "$TAG_ERROR_COLOR Cannot run lint inside $project_folder. Folder does not exists" 1>&2
        exit -1
    fi
fi
