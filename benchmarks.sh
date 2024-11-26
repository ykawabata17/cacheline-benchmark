#!/bin/bash

# 入力値のバリデーション関数
validate_input() {
  local input=$1
  local var_name=$2
  if [[ ! "$input" =~ ^[1-9][0-9]*$ ]]; then
    echo "エラー: ${var_name} は1以上の整数を入力してください。"
    return 1
  fi
  return 0
}

# ベンチマーク実行関数
run_benchmarks() {
  local data_type=$1
  shift
  local languages=("$@")
  local csv_file="results/results_${data_type}.csv"

  echo "Language,Row_Col_Time,Col_Row_Time" > "$csv_file"

  echo "${data_type}型の二次元配列のベンチマークを実行中..."

  for lang in "${languages[@]}"
  do
      case "$lang" in
          "C")
              (cd "$base_dir/c_${data_type}" && gcc -O1 -march=native -mtune=native -o main main.c)
              cmd="$base_dir/c_${data_type}/main $size $count"
              ;;
          "Go")
              (cd "$base_dir/go_${data_type}" && go build -a -o main main.go)
              cmd="$base_dir/go_${data_type}/main $size $count"
              ;;
          "Rust")
              (cd "$base_dir/rust_${data_type}" && cargo build --release --quiet)
              cmd="$base_dir/rust_${data_type}/target/release/main $size $count"
              ;;
          "Python")
              cmd="python3 $base_dir/python/main.py $size $count"
              ;;
          "Ruby")
              cmd="ruby $base_dir/ruby/main.rb $size $count"
              ;;
          *)
              echo "未対応の言語: $lang"
              continue
              ;;
      esac

      # コマンドの実行とエラーチェック
      if ! output=$($cmd); then
          echo "エラー: $lang のベンチマーク実行中に問題が発生しました。"
          continue
      fi

      # 結果の抽出
      row_col_time=$(echo "$output" | grep 'Average row_col function time' | awk '{print $5}')
      col_row_time=$(echo "$output" | grep 'Average col_row function time' | awk '{print $5}')

      # 'seconds'を削除
      row_col_time=${row_col_time% seconds}
      col_row_time=${col_row_time% seconds}

      # データをCSVファイルに追加
      echo "$lang,$row_col_time,$col_row_time" >> "$csv_file"
  done

  echo "ベンチマーク結果が${csv_file}に保存されました"
}

# メイン処理開始
echo "二次元配列のサイズ（行数と列数）を入力してください:"
while true; do
  read -p "サイズ: " size
  if validate_input "$size" "サイズ"; then
    break
  fi
done

echo "平均を取るための処理の繰り返し回数を入力してください:"
while true; do
  read -p "繰り返し回数: " count
  if validate_input "$count" "繰り返し回数"; then
    break
  fi
done

echo "入力されたサイズ: $size"
echo "入力された繰り返し回数: $count"

base_dir=$(pwd)
echo "ベンチマークを開始します..."

# int32 のベンチマーク
languages_int32=("C" "Go" "Rust")
run_benchmarks "int32" "${languages_int32[@]}"

# int64 のベンチマーク
languages_int64=("Python" "Ruby" "C" "Go" "Rust")
run_benchmarks "int64" "${languages_int64[@]}"
