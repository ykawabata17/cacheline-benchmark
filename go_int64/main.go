package main

import (
	"flag"
	"fmt"
	"strconv"
	"time"
)

func main() {
    // コマンドライン引数からsizeとiterationsを取得
    flag.Parse()
    size, _ := strconv.Atoi(flag.Arg(0))
    iterations, _ := strconv.Atoi(flag.Arg(1))

    a := setup(size)

    var rowColTotalTime time.Duration
    for iter := 0; iter < iterations; iter++ {
        start := time.Now()
        rowCol(size, a)
        elapsed := time.Since(start)
        rowColTotalTime += elapsed
    }
    rowColAvgTime := rowColTotalTime.Seconds() / float64(iterations)

    var colRowTotalTime time.Duration
    for iter := 0; iter < iterations; iter++ {
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
func setup(size int) [][]int64 {
    a := make([][]int64, size)
    for i := 0; i < size; i++ {
        a[i] = make([]int64, size)
    }
    return a
}

// 行方向から先に処理する
//go:noinline
func rowCol(size int, a [][]int64) {
    for i := 0; i < size; i++ {
        for j := 0; j < size; j++ {
            a[i][j] += 1
        }
    }
}

// 列方向から先に処理する
//go:noinline
func colRow(size int, a [][]int64) {
    for i := 0; i < size; i++ {
        for j := 0; j < size; j++ {
            a[j][i] += 1
        }
    }
}
