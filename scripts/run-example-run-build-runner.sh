#!/bin/bash

TAG="[widget-driver]:"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
TAG_COLOR="\n${GREEN}${TAG}${NC}"
TAG_ERROR_COLOR="\n${RED}${TAG}${NC}"

cd widget_driver/example
flutter pub get
flutter pub run build_runner build