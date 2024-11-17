import pandas as pd
import matplotlib.pyplot as plt
import japanize_matplotlib

def time_line_graph(data):
    plt.figure(figsize=(8, 6))
    plt.plot(data["Language"], data["Row_Col_Time"], marker="o", label="Row_Col")
    plt.plot(data["Language"], data["Col_Row_Time"], marker="x", label="Col_Row")
    plt.title("行方向と列方向の実行時間比較")
    plt.xlabel("言語")
    plt.ylabel("実行時間[s]")
    plt.grid(True, which="both", linestyle="--", linewidth=0.5)
    plt.legend()
    plt.savefig("./graph/time_line.png")

def graph_row_col_ratio(data):
    plt.figure(figsize=(8, 6))
    plt.bar(data["Language"], data["Ratio"])
    plt.title("行方向アクセスに対する列方向アクセスの処理時間の倍率")
    plt.xlabel("言語")
    plt.ylabel("行方向 / 列方向")
    plt.savefig("./graph/row_col_ratio.png")

def graph_compare_to_c(data):
    # 対数スケールで描画
    plt.figure(figsize=(10, 6))
    x = range(len(data))
    plt.bar(x, data["Row_Col_Relative_Percentage_To_C"], width=0.4, label="Row_Col", align='center', log=True)
    plt.bar(x, data["Col_Row_Relative_Percentage_To_C"], width=0.4, label="Col_Row", align='edge', log=True)

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
    data["Row_Col_Relative_Percentage_To_C"] = data["Row_Col_Time"] / data.loc[data["Language"] == "c", "Row_Col_Time"].values[0] * 100
    data["Col_Row_Relative_Percentage_To_C"] = data["Col_Row_Time"] / data.loc[data["Language"] == "c", "Col_Row_Time"].values[0] * 100

    time_line_graph(data)
    graph_row_col_ratio(data)
    graph_compare_to_c(data)

main()