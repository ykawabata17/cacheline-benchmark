import pandas as pd
import matplotlib.pyplot as plt
import japanize_matplotlib

def time_bar_graph(data):
    plt.figure(figsize=(8, 6))
    
    x = range(len(data["Language"]))  # 各言語のインデックスを作成
    width = 0.35  # 棒グラフの幅

    # 横並びの棒グラフをプロット
    row_col_positions = [i - width / 2 for i in x]
    col_row_positions = [i + width / 2 for i in x]
    
    plt.bar(row_col_positions, data["Row_Col_Time"], width, label="行方向", log=True, color='black')
    plt.bar(col_row_positions, data["Col_Row_Time"], width, label="列方向", log=True, color='gray')

    # グラフの設定
    plt.title("行方向と列方向の実行時間比較")
    plt.xlabel("言語")
    plt.ylabel("実行時間[s]")
    plt.yscale('log')
    plt.xticks(x, data["Language"])  # x軸に言語を表示
    plt.grid(True, which="both", linestyle="--", linewidth=0.5, axis="y")
    plt.legend()

    # グラフを保存
    plt.savefig("./graph/time_bar.png")

def graph_row_col_ratio(data):
    plt.figure(figsize=(8, 6))
    plt.bar(data["Language"], data["Ratio"])
    plt.title("行方向アクセスに対する列方向アクセスの処理時間の倍率")
    plt.xlabel("言語")
    plt.ylabel("行方向 / 列方向")
    plt.savefig("./graph/row_col_ratio.png")

def graph_compare_to_c(data):
    # 対数スケールで描画
    plt.figure(figsize=(8, 6))

    x = range(len(data["Language"]))  # 各言語のインデックスを作成
    width = 0.35  # 棒グラフの幅

    # 横並びの棒グラフをプロット
    row_col_positions = [i - width / 2 for i in x]
    col_row_positions = [i + width / 2 for i in x]

    plt.bar(row_col_positions, data["Row_Col_Relative_Percentage_To_C"], width, label="行方向", log=True, color='black')
    plt.bar(col_row_positions, data["Col_Row_Relative_Percentage_To_C"], width, label="列方向", log=True, color='gray')

    # ラベルの設定
    plt.xticks(x, data["Language"])
    plt.yscale('log')  # Y軸を対数スケールに設定
    plt.title("Cに対する各言語の実行時間の相対比較（対数スケール）")
    plt.xlabel("言語")
    plt.ylabel("Cとのパフォーマンス比[%]")
    plt.legend()
    plt.grid(True, which="both", linestyle="--", linewidth=0.5)
    plt.savefig("./graph/compare_to_c.png")

def main():
    data = pd.read_csv('results.csv')
    data["Ratio"] = data["Col_Row_Time"] / data["Row_Col_Time"]
    data["Row_Col_Relative_Percentage_To_C"] = data["Row_Col_Time"] / data.loc[data["Language"] == "C", "Row_Col_Time"].values[0] * 100
    data["Col_Row_Relative_Percentage_To_C"] = data["Col_Row_Time"] / data.loc[data["Language"] == "C", "Col_Row_Time"].values[0] * 100

    time_bar_graph(data)
    graph_row_col_ratio(data)
    graph_compare_to_c(data)

main()