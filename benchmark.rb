def setup
  a = []
  10240.times do
    a << ([0] * 10240)
  end
  a
end

def row_col(a)
  for i in (0...10240)
    for j in (0...10240)
      a[i][j] += 1
    end
  end
end

def col_row(a)
  for i in (0...10240)
    for j in (0...10240)
      a[j][i] += 1
    end
  end
end

require 'benchmark'

# 実行を5回繰り返して平均を計算
ITERATIONS = 5

def average_benchmark(iterations)
  row_col_times = []
  col_row_times = []

  iterations.times do
    a = setup
    row_col_time = Benchmark.realtime do
      row_col(a)
    end
    row_col_times << row_col_time

    a = setup
    col_row_time = Benchmark.realtime do
      col_row(a)
    end
    col_row_times << col_row_time
  end

  # 平均時間を計算
  average_row_col_time = row_col_times.sum / iterations
  average_col_row_time = col_row_times.sum / iterations

  puts "Average row_col function time: #{average_row_col_time.round(5)} seconds"
  puts "Average col_row function time: #{average_col_row_time.round(5)} seconds"
end

average_benchmark(ITERATIONS)
