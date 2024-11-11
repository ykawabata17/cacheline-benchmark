#!/bin/bash

NUM_RUNS=5
OUTPUT_FILE="output.txt"

# 既存のファイルがあれば削除（最初の実行時のみ）
# rm -f "$OUTPUT_FILE"

for i in $(seq 1 $NUM_RUNS); do
    echo "Run $i:" >> "$OUTPUT_FILE"
    multitime ./a.out >> "$OUTPUT_FILE" 2>&1
    echo -e "\n" >> "$OUTPUT_FILE"
done