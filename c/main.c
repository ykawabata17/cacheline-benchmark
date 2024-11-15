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
    for (int i = 0; i < size; i++) {
        a[i] = malloc(size * sizeof(int));
        if (a[i] == NULL) {
            fprintf(stderr, "Memory allocation failed.\n");
            exit(EXIT_FAILURE);
        }
        // 配列を0で初期化
        for (int j = 0; j < size; j++) {
            a[i][j] = 0;
        }
    }
    return a;
}

// メモリの解放
void cleanup(int size, int **a) {
    for (int i = 0; i < size; i++) {
        free(a[i]);
    }
    free(a);
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

int main(int argc, char *argv[]) {
    // コマンドライン引数からsizeとiterationsを取得
    int size = atoi(argv[1]);
    int iterations = atoi(argv[2]);

    double total_row_col_time = 0.0;
    double total_col_row_time = 0.0;

    for (int iter = 0; iter < iterations; iter++) {
        // row_col関数の実行
        int **a = setup(size);
        clock_t start = clock();
        row_col(size, a);
        clock_t end = clock();
        double duration = (double)(end - start) / CLOCKS_PER_SEC;
        total_row_col_time += duration;
        cleanup(size, a);

        // col_row関数の実行
        a = setup(size);
        start = clock();
        col_row(size, a);
        end = clock();
        duration = (double)(end - start) / CLOCKS_PER_SEC;
        total_col_row_time += duration;
        cleanup(size, a);
    }

    double avg_row_col_time = total_row_col_time / iterations;
    double avg_col_row_time = total_col_row_time / iterations;

    printf("Average row_col function time: %.5f seconds\n", avg_row_col_time);
    printf("Average col_row function time: %.5f seconds\n", avg_col_row_time);

    return 0;
}
