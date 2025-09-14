
# 🎬 Movie Correlation Analysis – Python Project

This project explores correlations between different features of movies such as **budget, gross earnings, company, and release year**.  
The goal is to identify trends and relationships in the movie industry using Python data analysis and visualization techniques.

---

## 📊 Dataset
- Source: Publicly available movies dataset (Kaggle/IMDB-style).  link: https://www.kaggle.com/datasets/danielgrijalvas/movies
- Contains columns such as: `budget`, `gross`, `company`, `released`, `score`, etc.  
- Data cleaning and preprocessing were performed to handle missing values and convert datatypes.

---

## 🛠️ Tools & Libraries
- **Python** (pandas, numpy, seaborn, matplotlib)
- **Jupyter Notebook** for analysis
- **Seaborn** & **Matplotlib** for visualizations

---

## 📈 Key Steps
1. **Data Cleaning**  
   - Converted `budget` and `gross` columns to integers  
   - Extracted `yearCorrect` from `released` column  
   - Handled missing values  

2. **Exploratory Data Analysis (EDA)**  
   - Used `.corr()` to calculate correlations between numeric features  
   - Visualized relationships using heatmaps and scatterplots  

3. **Findings**  
   - Strong correlation between **budget and gross earnings**  
   - Release year and company had weaker correlations  
   - Heatmap and regression plots provided better insights  

---

## 📷 Visualizations
- Correlation Heatmap of Numeric Features  
- Scatterplots of **Budget vs Gross Earnings**  

---

## 🚀 Results
- Movies with higher budgets generally tend to achieve higher gross earnings.  
- Other categorical factors like company and genre require further analysis.  

---
