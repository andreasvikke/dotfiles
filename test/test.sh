#!/bin/bash
set -e

mkdir ./src
cp -r ./../. /tmp/src && mv /tmp/src .

echo "Testing on Manjaro"
docker run --rm  \
    --user $UID:$GID \
    -v ./src:/test/ \
    --network host \
    --cap-add=NET_ADMIN \
    manjarolinux/base:latest \
    /bin/bash -c 'cd /test; ./install.sh -i'

rm -rf ./src
