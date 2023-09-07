#!/bin/bash

TAG="[widget-driver]:"
GREEN='\033[0;32m'
NC='\033[0m'
TAG_COLOR="\n${GREEN}${TAG}${NC}"

echo -e "$TAG_COLOR Generating code in example: $project_folder"
cd widget_driver/example
flutter pub get
dart run build_runner build --delete-conflicting-outputs