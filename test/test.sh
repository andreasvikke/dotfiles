#!/bin/bash

mkdir ./src
cp -a ./../. ./src/
sed -i 's/sudo//g' ./src/*

docker run --rm  \
    -v ./src:/test/ \
    ubuntu:23.04 \
    /bin/bash -c 'cd /test; ./install.sh -i -z'

rm -rf ./src
    
