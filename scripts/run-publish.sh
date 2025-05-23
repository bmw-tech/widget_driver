#!/bin/bash
set -e
# Script which publishes a release for a given plugin
TAG="[widget-driver]:"
GREEN='\033[0;32m'
NC='\033[0m'
TAG_COLOR="\n${GREEN}${TAG}${NC}"

# Read the tag passed as parameter which should be as package-version (e.g. widget_driver-1.2.3)
GIT_TAG=$1

# Extract the package from the git tag
DIRECTORY="${GIT_TAG%%-*}"
echo -e "$TAG_COLOR Publishing $DIRECTORY"
# If it doesn't exists, report an error
if [ ! -d "$DIRECTORY" ]; then
  echo -e "$TAG_COLOR $DIRECTORY doesn't exist. Make sure that tag name corresponds to one of the projects in the repo. Exiting..."
  exit 1
fi

echo -e "$TAG_COLOR Preparing to publish new version of $DIRECTORY"
cd $DIRECTORY || exit 2
version=$(grep '^version:' pubspec.yaml | awk '{print $2}')
flutter pub publish -f || exit 3

exit_code=$?
echo -e "$TAG_COLOR $DIRECTORY with version $version is successfully published."
exit 0