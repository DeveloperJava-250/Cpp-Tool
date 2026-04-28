#!/bin/bash

mkdir Project
mkdir Project/execute

cat > Project/program.cpp << EOF
#include <iostream>

int main(int argc, char* argv[]) {
    std::cout << "Hello Worlds\n";
    return 0;
}
EOF

cat > Project/Makefile << EOF 
.PHONY: build run
 
run: build
    @./execute/Program

build:
    @clang++ Program.cpp -o execute/Program
EOF