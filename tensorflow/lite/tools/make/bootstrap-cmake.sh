#!/bin/bash

rm -rf build

cmake -Bbuild -H. -DSANITIZE_ADDRESS=On \
 -DCMAKE_CXX_COMPILER=clang++ \
 -DCMAKE_C_COMPILER=clang
