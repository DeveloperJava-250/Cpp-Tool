#!/bin/bash

PROJECT_NAME=${1:-Project}

mkdir -p "$PROJECT_NAME/execute"

cat > "$PROJECT_NAME/Program.cpp" << EOF
#include <iostream>

int main(int argc, char* argv[]) {
    std::cout << "Hello Worlds\n";
    return 0;
}
EOF

cat > "$PROJECT_NAME/Makefile" << 'EOF'
.PHONY: build run

run: build
	@echo "Running..."
	@start=$$(date +%s%N); \
	./execute/Program; \
	end=$$(date +%s%N); \
	runtime=$$((($$end-$$start)/1000000)); \
	echo "Running Time: $${runtime} ms"

build:
	@mkdir -p execute
	@ccache clang++ Program.cpp -o execute/Program
EOF

echo "Building..."

start=$(date +%s%N)

make -C "$PROJECT_NAME" build

end=$(date +%s%N)

build_time=$(( (end - start) / 1000000 ))

echo "Build Time: ${build_time} ms"

make -C "$PROJECT_NAME" run