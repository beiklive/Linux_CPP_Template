#! /bin/bash

cd bin/
rm -rf *
cd ..
cd build/
rm -rf *
cmake .. && make