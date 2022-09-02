#! /bin/bash

if [[ ! -d build ]]; then
    mkdir build
fi

if [[ ! -d bin ]]; then
    mkdir bin
fi

cd bin/
rm -rf *
cd ..
cd build/
rm -rf *
cmake .. && make