package main

import "testing"

func BenchmarkRowCol(b *testing.B) {
    a := setup()

    b.ResetTimer() // タイマーをリセット
    for i := 0; i < b.N; i++ {
        rowCol(a)
    }
}

func BenchmarkColRow(b *testing.B) {
    a := setup()

    b.ResetTimer() // タイマーをリセット
    for i := 0; i < b.N; i++ {
        colRow(a)
    }
}
