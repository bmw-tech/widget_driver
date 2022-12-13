TAG="[widget-driver]:"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
TAG_COLOR="\n${GREEN}${TAG}${NC}"
PROJECT_FOLDERS=("widget_driver" "widget_driver_annotation" "widget_driver_generator" "widget_driver_test")

function run_watch() {
    cd widget_driver/example
    flutter run $@
}

run_watch $@