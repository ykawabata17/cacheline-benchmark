import sys
import timeit

# コマンドライン引数からsizeとiterationsを取得
SIZE = int(sys.argv[1])
ITERATIONS = int(sys.argv[2])

# 配列の初期化
a = [[0] * SIZE for _ in range(SIZE)]

# 行方向から先に処理する
def row_col(a):
    for i in range(SIZE):
        for j in range(SIZE):
            a[i][j] += 1

# 列方向から先に処理する
def col_row(a):
    for i in range(SIZE):
        for j in range(SIZE):
            a[j][i] += 1

if __name__ == '__main__':
    row_col_time = timeit.timeit("row_col(a)", setup="from __main__ import row_col, a", number=ITERATIONS)
    col_row_time = timeit.timeit("col_row(a)", setup="from __main__ import col_row, a", number=ITERATIONS)

    print(f"Average row_col function time: {(row_col_time / ITERATIONS):.5f} seconds")
    print(f"Average col_row function time: {(col_row_time / ITERATIONS):.5f} seconds")
