use std::time::{Duration, Instant};
use std::env;

// 配列の初期化
fn setup(size: usize) -> Vec<Vec<i32>> {
    vec![vec![0; size]; size]
}

// 行方向から先に処理する
fn row_col(size: usize, a: &mut Vec<Vec<i32>>) {
    for i in 0..size {
        for j in 0..size {
            a[i][j] += 1;
        }
    }
}

// 列方向から先に処理する
fn col_row(size: usize, a: &mut Vec<Vec<i32>>) {
    for i in 0..size {
        for j in 0..size {
            a[j][i] += 1;
        }
    }
}

fn main() {
    // コマンドライン引数からsizeとiterationsを取得
    let args: Vec<String> = env::args().collect();
    let size = args[1].parse::<usize>().unwrap();
    let iterations = args[2].parse::<usize>().unwrap();
    let warmup_count = args[3].parse::<usize>().unwrap();

    let mut total_row_col_time = Duration::new(0, 0);
    let mut total_col_row_time = Duration::new(0, 0);

    // ウォームアップ
    for _iter in 0..warmup_count {
        let mut a = setup(size);
        row_col(size, &mut a);
        let mut a = setup(size);
        col_row(size, &mut a);
    }

    for _iter in 0..iterations {

        // row_col関数の実行
        let mut a = setup(size);
        let start = Instant::now();
        row_col(size, &mut a);
        let duration = start.elapsed();
        total_row_col_time += duration;

        // col_row関数の実行
        let mut a = setup(size);
        let start = Instant::now();
        col_row(size, &mut a);
        let duration = start.elapsed();
        total_col_row_time += duration;
    }

    let avg_row_col_time = total_row_col_time / iterations as u32;
    let avg_col_row_time = total_col_row_time / iterations as u32;

    println!("Average row_col function time: {:.5} seconds", avg_row_col_time.as_secs_f64());
    println!("Average col_row function time: {:.5} seconds", avg_col_row_time.as_secs_f64());
}
