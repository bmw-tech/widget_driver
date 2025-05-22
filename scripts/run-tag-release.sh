#!/bin/bash
# Script creates git tags which are then picked up by the 
TAG="[widget-driver]:"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
TAG_COLOR="\n${GREEN}${TAG}${NC}"
PROJECT_FOLDERS=("widget_driver_annotation" "widget_driver_generator" "widget_driver" "widget_driver_test")

echo "$TAG_COLOR Preparing to publish new version"
for project_folder in "${PROJECT_FOLDERS[@]}"
do
    echo -e "$TAG_COLOR Preparing: $project_folder"
    cd $project_folder
    # Extract the version from the pubspec.yaml file
    version=$(grep '^version:' pubspec.yaml | awk '{print $2}')
    tag="$project_folder-$version"

    echo "$TAG_COLOR Creating Git tag for $project_folder and version: $version: $tag"
    git tag $tag
    git push origin $tag
    cd ..
done

echo "$TAG_COLOR Finished tagging project"