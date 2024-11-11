# 使い方
## ベンチマークを測りたいとき

以下のコマンドを実行する
```
$ go test -bench .
```

結果は以下のように出る。
```
goos: <OS>
goarch: <CPU のアーキテクチャ>
pkg: <パッケージ名>
cpu: <CPU の種類>
BenchmarkRowCol-<CPU数>   <実行回数>    <1回あたりの秒数 [ns/op]> 
BenchmarkColRow-<CPU数>   <実行回数>    <1回あたりの秒数 [ns/op]> 
PASS
ok      <パッケージ名>    <全体の処理時間>
```

CPU 数や実行回数は Go のランタイムが自動で設定してくれる。

### オプション
* CPU 数を指定したいとき
```
$ go test -bench . -cpu <CPU数>
``` 

* ベンチマークをとる回数を指定したいとき
```
$ go test -bench . -count <回数>
```

* メモリの割り当てられた統計を見たいとき
```
$ go test -bench . -benchmem
```

## プロファイリングを確認する
事前に graphviz が必要。
```
$ brew install graphviz
```

### CPU のプロファイルを web で確認する
```
$ go test -bench . -cpuprofile cpu.out
$ go tool pprof -http=":8888" cpu.out
```

### メモリーのプロファイルを web で確認する
```
$ go test -bench . -memprofile mem.out
$ go tool pprof -http=":8888" mem.out
```

