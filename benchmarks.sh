#!/bin/bash

languages=("python" "ruby" "go" "rust" "c")

echo "Language,Row_Col_Time,Col_Row_Time" > results.csv

base_dir=$(pwd)

for lang in "${languages[@]}"
do
    case "$lang" in
        "python")
            cmd="python3 $base_dir/python/main.py"
            ;;
        "ruby")
            cmd="ruby $base_dir/ruby/main.rb"
            ;;
        "go")
            (cd "$base_dir/go" && go build -o main main.go)
            cmd="$base_dir/go/main"
            ;;
        "rust")
            (cd "$base_dir/rust" && cargo build --release)
            cmd="$base_dir/rust/target/release/main"
            ;;
        "c")
            (cd "$base_dir/c" && gcc -O3 -o main main.c)
            cmd="$base_dir/c/main"
            ;;
    esac

    output=$($cmd)

    # grepとawkで時間を抽出
    row_col_time=$(echo "$output" | grep 'Average row_col function time' | awk '{print $5}')
    col_row_time=$(echo "$output" | grep 'Average col_row function time' | awk '{print $5}')

    # 'seconds'を削除
    row_col_time=${row_col_time% seconds}
    col_row_time=${col_row_time% seconds}

    # データをCSVファイルに追加
    echo "$lang,$row_col_time,$col_row_time" >> results.csv
done

echo "ベンチマーク結果がresults.csvに保存されました"
