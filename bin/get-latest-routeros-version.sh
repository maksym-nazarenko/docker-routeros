#!/bin/sh

set -e

version=$(curl https://mikrotik.com/download/archive \
| grep -o -E '/download/archive\?v=([.0-9]+)' \
| sed -n 's/^.*v=\(.*\)$/\1/p' \
| sort --reverse --version-sort \
| head -n1)

echo $version
