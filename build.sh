#! /bin/bash
mkdir build
cd build
cmake ../
make 
make install
rm -r ../build
../bin/test