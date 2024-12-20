#!/bin/sh

set -e

routeros_version=${1:?"RouterOS version must be provided as argument"}

git_root=$(git rev-parse --show-toplevel)
tag=$(git tag --list "${routeros_version}")
dockerfile=${git_root}/Dockerfile

if [ "$tag" != "" ]; then
    echo "tag exists, skipping new release creation"
    exit 0
fi


echo "Updating version in Dockerfile"

sed -i '.bak' -e 's/^ARG ROUTEROS_VERSION=.*/ARG ROUTEROS_VERSION='${routeros_version}'/' ${dockerfile}
git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git add ${dockerfile}
git commit -m "update RouterOS version to ${routeros_version}"
git tag ${routeros_version}
git push --tags

echo "Creating new release"
gh release create ${routeros_version} --prerelease --verify-tag --title "RouterOS ${routeros_version}"
