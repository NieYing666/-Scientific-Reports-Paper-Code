# 20230719 聂影 于 USM MECH
# 利用堆叠条形图，绘制文献分析
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# 加载数据
df = pd.read_csv('water turbidity.csv')

# 机器学习模型的关键词
ml_keywords = ["CNN", "SVM", "LSTM", "DT", "Random Forest", "Decision Tree", "Neural Network", "Deep Learning", "Gradient Boosting", "XGBoost", "AdaBoost", "K-Nearest Neighbors", "KNN", "Logistic Regression", "Naive Bayes", "Linear Regression"]

# 初始化一个空字典来保存计数
ml_counts = {keyword: {year: 0 for year in range(2008, 2024)} for keyword in ml_keywords}

# 在'Abstract'和'Title'列中搜索关键词
for index, row in df.iterrows():
    for keyword in ml_keywords:
        if keyword in row["Abstract"] or keyword in row["Title"]:
            ml_counts[keyword][row["Year"]] += 1

# 将计数转换为DataFrame以便于操作
ml_counts_df = pd.DataFrame(ml_counts)

# 更新时间范围为2013-2023
ml_counts_df = ml_counts_df.loc[2013:2023]

# 指定颜色以便于观察
colors = ['tab:blue', 'tab:orange', 'tab:green', 'tab:red', 'tab:purple', 'tab:brown', 'tab:pink', 'tab:gray', 'tab:olive', 'tab:cyan', 'darkblue', 'lime', 'cadetblue', 'hotpink', 'dodgerblue', 'tomato']

# 以条形图的形式绘制数据
fig, ax = plt.subplots(figsize=(15, 10))

# 我们将堆叠条形图，所以需要保持底部位置
bottom = np.zeros(len(ml_counts_df.index))

# 绘制每个机器学习模型
for i, column in enumerate(ml_counts_df.columns):
    ax.bar(ml_counts_df.index, ml_counts_df[column], bottom=bottom, label=column, color=colors[i % len(colors)])
    bottom += ml_counts_df[column]

ax.set_xlabel('Year', fontsize=14)
ax.set_ylabel('Number of Mentions', fontsize=14)
ax.set_title('Machine Learning on Water Turbidity over 2013 to 2023 base on Scopus Database Analysis', fontsize=18)
ax.legend(loc='upper left')
ax.tick_params(axis='x', labelsize=12)
ax.tick_params(axis='y', labelsize=12)

# 确保x轴显示每一年
ax.set_xticks(range(2013, 2024))

plt.show()

# 以600 dpi的分辨率保存图像
plt.savefig("stacked_bar_chart.png", dpi=600, bbox_inches='tight', pad_inches=0)
plt.close()



