#!/bin/bash

docker run --rm  \
    -v ./../:/test/ \
    ubuntu:23.04 \
    /bin/bash -c 'cd /test; ./install.sh -i -c'
    
