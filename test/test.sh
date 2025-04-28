#!/bin/bash
set -e

while getopts u flag
do
  case "${flag}" in
    u) ubuntu=true;;
  esac
done

mkdir ./src
cp -r ./../. /tmp/src && mv /tmp/src .

if [ "$ubuntu" ]; then
    echo "Testing on Ubuntu"
    docker run --rm  \
        --user $UID:$GID \
        -v ./src:/test/ \
        --network host \
        --cap-add=NET_ADMIN \
        ubuntu:23.10 \
        /bin/bash -c 'cd /test; ./install.sh -i'
else
    echo "Testing on Manjaro"
    docker run --rm  \
        --user $UID:$GID \
        -v ./src:/test/ \
        --network host \
        --cap-add=NET_ADMIN \
        manjarolinux/base:latest \
        /bin/bash -c 'cd /test; ./install.sh -i'
fi

rm -rf ./src
