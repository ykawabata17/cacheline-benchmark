use std::time::{Duration, Instant};

const SIZE: usize = 10240;
const ITERATIONS: usize = 5;

// 配列の初期化
fn setup() -> Vec<Vec<i32>> {
    vec![vec![0; SIZE]; SIZE]
}

// 行方向から先に処理する
fn row_col(a: &mut Vec<Vec<i32>>) {
    for i in 0..SIZE {
        for j in 0..SIZE {
            a[i][j] += 1;
        }
    }
}

// 列方向から先に処理する
fn col_row(a: &mut Vec<Vec<i32>>) {
    for i in 0..SIZE {
        for j in 0..SIZE {
            a[j][i] += 1;
        }
    }
}

fn main() {
    let mut total_row_col_time = Duration::new(0, 0);
    let mut total_col_row_time = Duration::new(0, 0);

    for _iter in 1..=ITERATIONS {

        // row_col関数の実行
        let mut a = setup();
        let start = Instant::now();
        row_col(&mut a);
        let duration = start.elapsed();
        total_row_col_time += duration;

        // col_row関数の実行
        let mut a = setup();
        let start = Instant::now();
        col_row(&mut a);
        let duration = start.elapsed();
        total_col_row_time += duration;
    }

    let avg_row_col_time = total_row_col_time / ITERATIONS as u32;
    let avg_col_row_time = total_col_row_time / ITERATIONS as u32;

    println!("Average row_col function time: {:.5} seconds", avg_row_col_time.as_secs_f64());
    println!("Average col_row function time: {:.5} seconds", avg_col_row_time.as_secs_f64());
}
