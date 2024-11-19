#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// 配列の初期化
int** setup(int size) {
    int **a = malloc(size * sizeof(int*));
    if (a == NULL) {
        fprintf(stderr, "Memory allocation failed.\n");
        exit(EXIT_FAILURE);
    }

    // size * size 分のメモリを一度に確保する
    int *data = calloc(size * size, sizeof(int));
    if (data == NULL) {
        fprintf(stderr, "Memory allocation failed.\n");
        exit(EXIT_FAILURE);
    }

    // ポインタ配列 a[] を適切な位置に設定
    for (int i = 0; i < size; i++) {
        a[i] = data + i * size;
    }

    return a;
}

// メモリの解放
void cleanup(int size, int **a) {
    if (a != NULL) {
        free(a[0]); // data のメモリ解放
        free(a);    // ポインタ配列 a のメモリ解放
    }
}

// 行方向から先に処理する
void row_col(int size, int **a) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            a[i][j] += 1;
        }
    }
}

// 列方向から先に処理する
void col_row(int size, int **a) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            a[j][i] += 1;
        }
    }
}

int main(int _argc, char *argv[]) {
    // コマンドライン引数からsizeとiterationsを取得
    int size = atoi(argv[1]);
    int iterations = atoi(argv[2]);
    int warmup_count = atoi(argv[3]);

    double total_row_col_time = 0.0;
    double total_col_row_time = 0.0;

    // ウォームアップ
    for (int iter = 0; iter < warmup_count; iter++) {
        // row_col関数の実行
        int **a = setup(size);
        row_col(size, a);
        cleanup(size, a);

        // col_row関数の実行
        a = setup(size);
        col_row(size, a);
        cleanup(size, a);
    }

    for (int iter = 0; iter < iterations; iter++) {
        // row_col関数の実行
        int **a = setup(size);
        struct timespec start, end;
        clock_gettime(CLOCK_MONOTONIC, &start);
        row_col(size, a);
        clock_gettime(CLOCK_MONOTONIC, &end);
        cleanup(size, a);
        double elapsed = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
        total_row_col_time += elapsed;

        // col_row関数の実行
        a = setup(size);
        clock_gettime(CLOCK_MONOTONIC, &start);
        col_row(size, a);
        clock_gettime(CLOCK_MONOTONIC, &end);
        cleanup(size, a);
        elapsed = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
        total_col_row_time += elapsed;
    }

    double avg_row_col_time = total_row_col_time / iterations;
    double avg_col_row_time = total_col_row_time / iterations;

    printf("Average row_col function time: %.5f seconds\n", avg_row_col_time);
    printf("Average col_row function time: %.5f seconds\n", avg_col_row_time);

    return 0;
}
