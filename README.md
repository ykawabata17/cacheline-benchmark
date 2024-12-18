# cacheline-benchmark

キャッシュライン最適化の効果を異なるプログラミング言語で比較するためのベンチマークスイートです。

# 概要

このリポジトリでは、大規模な配列に対して行方向および列方向のアクセスを行い、その実行時間を Python、Ruby、C、Go、Rust、言語で比較しています。  
これにより、キャッシュラインの利用がプログラムのパフォーマンスに与える影響と、各言語がメモリアクセスパターンをどのように処理するかを明らかにします。

# ベンチマークの詳細

ベンチマークは以下の 2 種類の操作を行います：

行方向アクセス (row_col)： 配列の要素を行ごとに順番にアクセスします。メモリ上の配置とアクセスパターンが一致するため、キャッシュ効率が高まります。
列方向アクセス (col_row)： 配列の要素を列ごとにアクセスします。メモリ上の配置とアクセスパターンが不一致となり、キャッシュミスが増加します。

ベンチマークの結果や考察はこちら(リリースされたらリンクを張る)のブログを参照してください。

# ベンチマークの実行方法

## 前提条件

各言語のコンパイラやインタプリタをインストールしてください。
Python：バージョン 3.x
Ruby：バージョン 3.x
Go：最新の安定版
Rust：最新の安定版（rustup でインストールを推奨）
C：GCC または Clang

## 手順

1. リポジトリをクローンします

```bash
$ git clone https://github.com/ykawabata17/cacheline-benchmark.git
$ cd cacheline-benchmark
```

2. 全言語のベンチマークを実行します

- オプションで配列の要素数と処理の繰り返し回数を指定できます
- ブログでは 要素数: 10240, 繰り返し回数: 5 としています

```bash
$ chmod 755 benchmarks.sh
$ ./benchmarks.sh
> 二次元配列のサイズ（行数と列数）を入力してください:
> サイズ: 50000 ↓
> 平均を取るための処理の繰り返し回数を入力してください:
> 繰り返し回数: 5 ↓
> ベンチマークを開始します...
```

3. 結果は results/ 配下に CSV 形式で出力されます
