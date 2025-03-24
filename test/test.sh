#!/bin/bash
set -e

while getopts u flag
do
  case "${flag}" in
    m) ubuntu=true;;
  esac
done

mkdir ./src
cp -r ./../. /tmp/src && mv /tmp/src .
# find . -type f -exec sed -i 's///g' {} \;

if [ "$ubuntu" ]; then
    echo "Testing on Ubuntu"
    docker run --rm  \
        -v ./src:/test/ \
        --network host \
        ubuntu:23.10 \
        /bin/bash -c 'cd /test; ./install.sh -i'
else
    echo "Testing on Manjaro"
    docker run --rm  \
        -v ./src:/test/ \
        --network host \
        manjarolinux/base:latest \
        /bin/bash -c 'cd /test; ./install.sh -i'
fi

rm -rf ./src
