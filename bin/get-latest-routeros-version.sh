#!/bin/sh

set -e

version=$(curl -s https://cdn.mikrotik.com/routeros/latest-stable.rss \
| grep -o -E '/download\?v=([.0-9]+)' \
| sed -n 's/^.*v=\(.*\)$/\1/p' \
| sort --reverse --version-sort \
| head -n1)

if [ -z "$version" ]; then
    echo "no version extracted from download page"
    exit 1
fi

echo $version
