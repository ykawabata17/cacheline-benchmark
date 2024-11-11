package main

const (
	SIZE = 10240
)

func setup() [][]int {
    a := make([][]int, SIZE)
    for i := 0; i < SIZE; i++ {
        a[i] = make([]int, SIZE)
    }
    return a
}

func rowCol(a [][]int) {
    for i := 0; i < SIZE; i++ {
        for j := 0; j < SIZE; j++ {
            a[i][j] += 1
        }
    }
}

func colRow(a [][]int) {
    for i := 0; i < SIZE; i++ {
        for j := 0; j < SIZE; j++ {
            a[j][i] += 1
        }
    }
}
