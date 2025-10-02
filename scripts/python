import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt 

data = {
"ROUTE": [
"Denver → San Diego",
"Orlando → Denver",
"San Diego → Las Vegas",
"San Diego → Denver",
"Denver → Orlando",
"Delhi → Orlando",
"Orlando → San Diego",
"Las Vegas → Denver",
"Chicago → Orlando",
"Orlando → Las Vegas"
    ],
"Cabin Staff": [1.76, 1.45, 1.60, 1.27, 1.42, 1.77, 1.61, 1.95, 1.82, 1.81],
"Entertainment": [1.00, 1.00, 1.10, 1.00, 1.11, 1.00, 1.20, 1.00, 1.08, 1.00],
"Food": [1.24, 1.06, 1.00, 1.22, 1.29, 1.08, 1.29, 1.13, 1.36, 1.00],
"Seat Comfort": [1.42, 1.26, 1.42, 1.30, 1.13, 1.23, 1.43, 1.30, 1.32, 1.14],
"Wifi": [1.00, 1.00, 1.00, 1.00, 1.17, 1.00, 1.00, 1.00, 1.00, 1.00]
}

df = pd.DataFrame(data)

df_melt = df.melt(id_vars=["ROUTE"], var_name="Key Metrics", value_name="Avg_Score")
heatmap_data = df_melt.pivot(index="ROUTE", columns="Key Metrics", values="Avg_Score")

mode_dark_bg = "#1a1a23"
frontier_green = "#007A33"

plt.figure(figsize=(10, 6))
ax=sns.heatmap(heatmap_data, annot=True, cmap="Greens", cbar_kws={'label': 'Avg Score'}, fmt=".2f")

ax.set_facecolor(mode_dark_bg)            # inside chart
plt.gcf().set_facecolor(mode_dark_bg)     # figure background
ax.figure.patch.set_facecolor(mode_dark_bg)

ax.set_title("Top 10 Routes: In-flight Service Performance",
             fontsize=14, weight='bold', color="white")
ax.set_xlabel("Key Metrics", color="white")
ax.set_ylabel("Route", color="white")

ax.tick_params(axis='x', colors="white", rotation=30)
ax.tick_params(axis='y', colors="white")

cbar = ax.collections[0].colorbar
cbar.ax.yaxis.label.set_color("white")
cbar.ax.tick_params(colors="white")

plt.title("Top 10 Routes: In-flight Service Performance", fontsize=12, weight='bold')
plt.ylabel("Route")
plt.xticks(rotation=30)
plt.tight_layout()
plt.show()
