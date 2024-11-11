#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SIZE 10240
#define ITERATIONS 5

// 配列の初期化
int** setup() {
    int **a = malloc(SIZE * sizeof(int*));
    if (a == NULL) {
        fprintf(stderr, "メモリ割り当てに失敗しました。\n");
        exit(EXIT_FAILURE);
    }
    for (int i = 0; i < SIZE; i++) {
        a[i] = malloc(SIZE * sizeof(int));
        if (a[i] == NULL) {
            fprintf(stderr, "メモリ割り当てに失敗しました。\n");
            exit(EXIT_FAILURE);
        }
        // 配列を0で初期化
        for (int j = 0; j < SIZE; j++) {
            a[i][j] = 0;
        }
    }
    return a;
}

// 配列の解放
void cleanup(int **a) {
    for (int i = 0; i < SIZE; i++) {
        free(a[i]);
    }
    free(a);
}

// row_col関数：行方向のアクセス
void row_col(int **a) {
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            a[i][j] += 1;
        }
    }
}

// col_row関数：列方向のアクセス
void col_row(int **a) {
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            a[j][i] += 1;
        }
    }
}

int main() {
    double total_row_col_time = 0.0;
    double total_col_row_time = 0.0;

    for (int iter = 0; iter < ITERATIONS; iter++) {
        printf("Iteration %d:\n", iter + 1);

        // row_col関数の実行
        int **a = setup();
        clock_t start = clock();
        row_col(a);
        clock_t end = clock();
        double duration = (double)(end - start) / CLOCKS_PER_SEC;
        total_row_col_time += duration;
        printf("  row_col function time: %.5f seconds\n", duration);
        cleanup(a);

        // col_row関数の実行
        a = setup();
        start = clock();
        col_row(a);
        end = clock();
        duration = (double)(end - start) / CLOCKS_PER_SEC;
        total_col_row_time += duration;
        printf("  col_row function time: %.5f seconds\n", duration);
        cleanup(a);
    }

    double avg_row_col_time = total_row_col_time / ITERATIONS;
    double avg_col_row_time = total_col_row_time / ITERATIONS;

    printf("\nAverage row_col function time: %.5f seconds\n", avg_row_col_time);
    printf("Average col_row function time: %.5f seconds\n", avg_col_row_time);

    return 0;
}
