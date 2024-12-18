require 'benchmark'

# コマンドライン引数からsizeとiterationsを取得
SIZE = ARGV[0].to_i
ITERATIONS = ARGV[1].to_i

# 配列の初期化
def setup
  Array.new(SIZE) { Array.new(SIZE, 0) }
end

# 行方向から先に処理する
def row_col(a)
  SIZE.times do |i|
    SIZE.times do |j|
      a[i][j] += 1
    end
  end
end

# 列方向から先に処理する
def col_row(a)
  SIZE.times do |i|
    SIZE.times do |j|
      a[j][i] += 1
    end
  end
end

def benchmark(iterations)
  row_col_times = []
  col_row_times = []

  iterations.times do
    a = setup
    row_col_time = Benchmark.realtime { row_col(a) }
    row_col_times << row_col_time

    a = setup
    col_row_time = Benchmark.realtime { col_row(a) }
    col_row_times << col_row_time
  end

  average_row_col_time = row_col_times.sum / iterations
  puts "Average row_col function time: #{average_row_col_time.round(5)} seconds"

  average_col_row_time = col_row_times.sum / iterations
  puts "Average col_row function time: #{average_col_row_time.round(5)} seconds"
end

benchmark(ITERATIONS)
