import timeit

ITERATIONS = 5

# 配列の初期化
a = [[0] * 10240 for _ in range(10240)]

# 行方向から先に処理する
def row_col(a):
    for i in range(10240):
        for j in range(10240):
            a[i][j] += 1

# 列方向から先に処理する
def col_row(a):
    for i in range(10240):
        for j in range(10240):
            a[j][i] += 1

if __name__ == '__main__':
    row_col_time = timeit.timeit("row_col(a)", setup="from __main__ import row_col, a", number=ITERATIONS)
    col_row_time = timeit.timeit("col_row(a)", setup="from __main__ import col_row, a", number=ITERATIONS)

    print(f"Average row_col function time: {(row_col_time / ITERATIONS):.5f} seconds")
    print(f"Average col_row function time: {(col_row_time / ITERATIONS):.5f} seconds")
