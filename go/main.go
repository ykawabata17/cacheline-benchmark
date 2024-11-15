package main

import (
    "fmt"
    "time"
)

const (
	SIZE = 10240
    ITERATIONS = 5
)

func main() {
    a := setup()

    var rowColTotalTime time.Duration
    for iter := 0; iter < ITERATIONS; iter++ {
        start := time.Now()
        rowCol(a)
        elapsed := time.Since(start)
        rowColTotalTime += elapsed
    }
    rowColAvgTime := rowColTotalTime.Seconds() / float64(ITERATIONS)

    var colRowTotalTime time.Duration
    for iter := 0; iter < ITERATIONS; iter++ {
        start := time.Now()
        colRow(a)
        elapsed := time.Since(start)
        colRowTotalTime += elapsed
    }
    colRowAvgTime := colRowTotalTime.Seconds() / float64(ITERATIONS)

    fmt.Printf("Average row_col function time: %.5f seconds\n", rowColAvgTime)
    fmt.Printf("Average col_row function time: %.5f seconds\n", colRowAvgTime)
}

// 配列の初期化
func setup() [][]int {
    a := make([][]int, SIZE)
    for i := 0; i < SIZE; i++ {
        a[i] = make([]int, SIZE)
    }
    return a
}

// 行方向から先に処理する
func rowCol(a [][]int) {
    for i := 0; i < SIZE; i++ {
        for j := 0; j < SIZE; j++ {
            a[i][j] += 1
        }
    }
}

// 列方向から先に処理する
func colRow(a [][]int) {
    for i := 0; i < SIZE; i++ {
        for j := 0; j < SIZE; j++ {
            a[j][i] += 1
        }
    }
}
