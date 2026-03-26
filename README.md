# rk.correspondence: Multivariate Analysis for RKWard

![Version](https://img.shields.io/badge/Version-0.0.1-blue.svg)
![License](https://img.shields.io/badge/License-GPLv3-blue.svg)
![RKWard](https://img.shields.io/badge/Platform-RKWard-green)
[![R Linter](https://github.com/AlfCano/rk.correspondence/actions/workflows/lintr.yml/badge.svg)](https://github.com/AlfCano/rk.correspondence/actions/workflows/lintr.yml)

**rk.correspondence** brings modern, visually appealing multivariate statistics to the RKWard GUI. Powered by the industry-standard `FactoMineR` and `factoextra` packages, this plugin provides an intuitive, "R Commander-style" interface to compute and visualize Simple and Multiple Correspondence Analysis without writing a single line of code.

## 🚀 What's New in Version 0.0.1

This is the initial release of the package, introducing two core statistical tools for categorical data exploration:

1.  **Simple Correspondence Analysis (CA):** Analyze two-way contingency tables, customize biplots, and filter categories by their statistical contribution or quality of representation ($cos^2$).
2.  **Multiple Correspondence Analysis (MCA):** Explore patterns across multiple categorical variables simultaneously, isolate individuals or variables in the plot, and control dimensionality.

### 🌍 Internationalization
The interface is fully localized in:
*   🇺🇸 English (Default)
*   🇪🇸 Spanish (`es`)
*   🇫🇷 French (`fr`)
*   🇩🇪 German (`de`)
*   🇧🇷 Portuguese (Brazil) (`pt_BR`)

## ✨ Features

### 1. Simple CA (Contingency Tables)
*   **Dimensionality Control:** Choose how many dimensions to retain (`ncp`) and exactly which axes to plot (e.g., Dim 1 vs Dim 3).
*   **Advanced Filtering:** Declutter your plots by showing only the "Top N Contributors" or points with a specific quality of representation ($cos^2$) threshold.
*   **Aesthetics:** Instantly change row and column colors, and use `repel` to prevent text labels from overlapping.

### 2. Multiple CA (Large Datasets)
*   **Active Variable Selection:** Easily select multiple categorical variables from a large data frame using a multi-selection list.
*   **Plot Isolation:** Toggle between plotting the full Biplot, Variables only, or Individuals only to uncover different data structures.

### 🛡️ Universal Features
*   **Live Plot Preview:** Adjust colors, axes, and filters while seeing the `ggplot2`-based biplot update in real-time before running the final model.
*   **Object Saving:** Automatically saves the complex `FactoMineR` result objects to your R Global Environment for further scripting or exporting.

## 📦 Installation

This plugin is available via GitHub. Use the `remotes` or `devtools` package in RKWard to install it.

1.  **Open RKWard**.
2.  **Run the following command** in the R Console:

    ```R
    # If you don't have devtools installed:
    # install.packages("devtools")
    
    local({
      require(devtools)
      install_github("AlfCano/rk.correspondence", force = TRUE)
    })
    ```
3.  **Restart RKWard** to load the new menu entries.

## 💻 Usage & Testing Instructions

Once installed, the tools are organized under:
**`Analysis` -> `Multivariate`**

You can test the plugins immediately using R's built-in datasets. Copy and paste this into your RKWard console to prepare the test data:

```R
# 1. Data for Simple CA (Contingency table)
tabla_ca <- margin.table(HairEyeColor, c(1, 2))

# 2. Data for Multiple CA (Dataset 'tea' from FactoMineR)
data(tea, package = "FactoMineR")
datos_mca <- tea[, c("Tea", "How", "how", "sugar", "where", "always")]
```

### Test 1: Simple CA
1. Go to **Analysis -> Multivariate -> Simple CA**.
2. **Data tab:** Select `tabla_ca`.
3. **Plot Options tab:** Click **Preview**. Change the "Row color" to `darkgreen` and "Column color" to `purple`. Try filtering by "Top Contributors" and set the threshold to `3`.
4. Click **Submit**. Check your Output window for the statistical summary and the final plot.

### Test 2: Multiple CA
1. Go to **Analysis -> Multivariate -> Multiple CA**.
2. **Data & Variables tab:** Select `datos_mca` as the Dataset. Select **all** variables in the list and move them to "Active Categorical Variables".
3. **Plot Options tab:** Click **Preview**. Change "Plot Type" to **Variables only** to see a cleaner graph.
4. Click **Submit**. Check your R Workspace; you will see the `resultado_mca` object saved and ready to use.

## 🛠️ Dependencies

This plugin relies on the following R packages:
*   `FactoMineR` (Statistical computation)
*   `factoextra` (ggplot2-based visualization)
*   `rkwarddev` (Plugin generation)

## ✍️ Author & License

*   **Author:** Alfonso Cano (<alfonso.cano@correo.buap.mx>)
*   **Assisted by:** Gemini, a large language model from Google.
*   **License:** GPL (>= 3)
