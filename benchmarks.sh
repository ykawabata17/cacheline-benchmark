#!/bin/bash

validate_input() {
  local input=$1
  if [[ ! "$input" =~ ^[1-9][0-9]*$ ]]; then
    echo "エラー: 整数値を1以上で入力してください。"
    return 1
  fi
  return 0
}

# size の入力とバリデーション
echo "二次元配列のサイズ（行数と列数）を入力してください:"
while true; do
  read -p "サイズ: " size
  if validate_input "$size"; then
    break
  fi
done

# count の入力とバリデーション
echo "平均を取るための処理の繰り返し回数を入力してください:"
while true; do
  read -p "繰り返し回数: " count
  if validate_input "$count"; then
    break
  fi
done

echo "入力されたサイズ: $size"
echo "入力された繰り返し回数: $count"

languages=("python" "ruby" "c" "go" "rust")

echo "Language,Row_Col_Time,Col_Row_Time" > results.csv

base_dir=$(pwd)

echo "ベンチマークを開始します..."

for lang in "${languages[@]}"
do
    case "$lang" in
        "python")
            cmd="python3 $base_dir/python/main.py $size $count"
            ;;
        "ruby")
            cmd="ruby $base_dir/ruby/main.rb $size $count"
            ;;
        "c")
            (cd "$base_dir/c" && gcc -O3 -march=native -mtune=native -o main main.c)
            cmd="$base_dir/c/main $size $count"
            ;;
        "go")
            (cd "$base_dir/go" && go build -o main main.go)
            cmd="$base_dir/go/main $size $count"
            ;;
        "rust")
            (cd "$base_dir/rust" && cargo build --release)
            cmd="$base_dir/rust/target/release/main $size $count"
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
