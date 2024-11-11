use std::time::{Duration, Instant};

const SIZE: usize = 10240;
const ITERATIONS: usize = 5;

fn setup() -> Vec<Vec<i32>> {
    vec![vec![0; SIZE]; SIZE]
}

fn row_col(a: &mut Vec<Vec<i32>>) {
    for i in 0..SIZE {
        for j in 0..SIZE {
            a[i][j] += 1;
        }
    }
}

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

    for iter in 1..=ITERATIONS {
        println!("Iteration {}:", iter);

        // row_col関数の実行
        let mut a = setup();
        let start = Instant::now();
        row_col(&mut a);
        let duration = start.elapsed();
        total_row_col_time += duration;
        println!("  row_col function time: {:.5} seconds", duration.as_secs_f64());

        // col_row関数の実行
        let mut a = setup();
        let start = Instant::now();
        col_row(&mut a);
        let duration = start.elapsed();
        total_col_row_time += duration;
        println!("  col_row function time: {:.5} seconds", duration.as_secs_f64());
    }

    let avg_row_col_time = total_row_col_time / ITERATIONS as u32;
    let avg_col_row_time = total_col_row_time / ITERATIONS as u32;

    println!("\nAverage row_col function time: {:.5} seconds", avg_row_col_time.as_secs_f64());
    println!("Average col_row function time: {:.5} seconds", avg_col_row_time.as_secs_f64());
}
