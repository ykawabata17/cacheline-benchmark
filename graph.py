import pandas as pd
import matplotlib.pyplot as plt
import japanize_matplotlib

def graph_row_col_ratio(data):
    plt.figure(figsize=(8, 6))
    plt.bar(data["Language"], data["Ratio"])
    plt.title("行先行と列先行の倍率比較")
    plt.xlabel("言語")
    plt.ylabel("行先行 / 列先行")
    plt.show()

def graph_compare_to_c(data):
    # 対数スケールで描画
    plt.figure(figsize=(10, 6))
    x = range(len(data))
    plt.bar(x, data["Row_Col_vs_C"], width=0.4, label="Row_Col vs C", align='center', log=True)
    plt.bar(x, data["Col_Row_vs_C"], width=0.4, label="Col_Row vs C", align='edge', log=True)

    # ラベルの設定
    plt.xticks(x, data["Language"])
    plt.yscale('log')  # Y軸を対数スケールに設定
    plt.title("C言語を基準とした速度比較")
    plt.xlabel("言語")
    plt.ylabel("C言語とのパフォーマンス比[%]")
    plt.legend()
    plt.grid(True, which="both", linestyle="--", linewidth=0.5)
    plt.show()

def main():
    data = pd.read_csv('results.csv')
    data["Ratio"] = data["Col_Row_Time"] / data["Row_Col_Time"]
    data["Row_Col_vs_C"] = data["Row_Col_Time"] / data.loc[data["Language"] == "c", "Row_Col_Time"].values[0] * 100
    data["Col_Row_vs_C"] = data["Col_Row_Time"] / data.loc[data["Language"] == "c", "Col_Row_Time"].values[0] * 100

    graph_row_col_ratio(data)
    graph_compare_to_c(data)

main()