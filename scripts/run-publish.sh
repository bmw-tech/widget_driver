#!/bin/bash

TAG="[widget-driver]:"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
TAG_COLOR="\n${GREEN}${TAG}${NC}"
PROJECT_FOLDERS=("widget_driver_annotation" "widget_driver_generator" "widget_driver" "widget_driver_test")


for project_folder in "${PROJECT_FOLDERS[@]}"
do
    echo -e "$TAG_COLOR Preparing: $project_folder"
    cd $project_folder
    dart pub publish -f
    cd ..
done