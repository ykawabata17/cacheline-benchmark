#!/bin/bash

# This script is used to run the benchmarks for the project.

cd $PWD/c && gcc -O3 -o main main.c && ./main

cd $PWD/rust && cargo build --release && target/release/main

cd $PWD/go && go test -bench .

cd $PWD/ruby && ruby main.rb

cd $PWD/python && python3 main.py
