#!/bin/sh

set -e

routeros_version=${1:?"RouterOS version must be provided as argument"}

git_root=$(git rev-parse --show-toplevel)
tag=$(git tag --list "${routeros_version}")

if [ "$tag" != "" ]; then
    echo "tag exists, skipping new release creation"
    exit 0
fi

echo "Creating new release"

gh release create $routeros_version --prerelease --title "RouterOS ${routeros_version}"
