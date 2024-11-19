package main

import (
	"flag"
	"fmt"
	"time"
    "strconv"
)

func main() {
    // コマンドライン引数からsizeとiterationsを取得
    flag.Parse()
    size, _ := strconv.Atoi(flag.Arg(0))
    iterations, _ := strconv.Atoi(flag.Arg(1))
    warmupCount, _ := strconv.Atoi(flag.Arg(2))

    // ウォームアップ
    for iter := 0; iter < warmupCount; iter++ {
        a := setup(size)
        rowCol(size, a)
    }
    for iter := 0; iter < warmupCount; iter++ {
        a := setup(size)
        colRow(size, a)
    }

    var rowColTotalTime time.Duration
    for iter := 0; iter < iterations; iter++ {
        a := setup(size)
        start := time.Now()
        rowCol(size, a)
        elapsed := time.Since(start)
        rowColTotalTime += elapsed
    }
    rowColAvgTime := rowColTotalTime.Seconds() / float64(iterations)

    var colRowTotalTime time.Duration
    for iter := 0; iter < iterations; iter++ {
        a := setup(size)
        start := time.Now()
        colRow(size, a)
        elapsed := time.Since(start)
        colRowTotalTime += elapsed
    }
    colRowAvgTime := colRowTotalTime.Seconds() / float64(iterations)

    fmt.Printf("Average row_col function time: %.5f seconds\n", rowColAvgTime)
    fmt.Printf("Average col_row function time: %.5f seconds\n", colRowAvgTime)
}

// 配列の初期化
func setup(size int) [][]int {
    a := make([][]int, size)
    for i := 0; i < size; i++ {
        a[i] = make([]int, size)
    }
    return a
}

// 行方向から先に処理する
func rowCol(size int, a [][]int) {
    for i := 0; i < size; i++ {
        for j := 0; j < size; j++ {
            a[i][j] += 1
        }
    }
}

// 列方向から先に処理する
func colRow(size int, a [][]int) {
    for i := 0; i < size; i++ {
        for j := 0; j < size; j++ {
            a[j][i] += 1
        }
    }
}
