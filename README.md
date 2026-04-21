# The Low-Budget Advantage: A Data-Driven Case Against Hollywood's Blockbuster Bias

**By Derek Lein** [Portfolio](https://dereklein.carrd.co/) | [LinkedIn](https://www.linkedin.com/in/derek-lein-4171a6291/)

---

## 🎬 Project Overview
As an assistant editor with nearly a decade of experience in the film industry, and currently transitioning to the data analytics field, I recognized a worrying trend in the box office trends of the modern era: more films produced each year with over $100M budgets, but fewer total films being produced overall.

This project utilizes **SQL** for data engineering and **Excel** for strategic aggregation and visualization to identify which budget class of films is the smartest investment within the current landscape.

---

## 🛠️ Tech Stack & Methodology
* **SQL:** Data selection, standardization, and cleaning
* **Excel:** Data aggregation and visualization

---

## 📈 Key Strategic Questions
1. **High-Budget vs Low-Budget Profitability:** Which budget class shows the highest profits and ROI?
2. **Assessing Effects of Franchises:** Does IP have a significant effect on each budget class?
3. **Investment Priority:** Which types of films are the safest investments?

---

## 🎯 Insights & Conclusions
1. **Low-Budget High-Volume:** Low-budget films consistently average higher ROI than mid or high-budget films, yet the film industry makes more high-budget films and fewer total films with each passing year. Shifting to greenlighting considerably more low-budget films will help alleviate the current high risk concentration felt across the industry, as well as foster new creative talent and a more stable financial state.
2. **Franchise Weight:** Franchise films average higher ROI than standalone films across every budget class, including low-budget. However, both the franchise and standalone ROIs for low-budget films vastly outperform the franchise ROIs for mid and high-budget films, suggesting low-budget films are less beholden to IP for success.
3. **Genre Blindspots:** The musical, adventure, action, and horror genres show the highest profits and ROIs. While horror films are frequently made within the low-budget category, and often quite successfully, branching out into the former three genres which are not often associated with low-budget filmmaking could present an untapped opportunity for a wider audience.
---

## 📂 Repository Structure
* `BoxOfficeAnalysis_LowBudgetAdvantage.pdf`: The full technical report.
  * [**View the Full Technical Analysis**](https://github.com/derekmlein/box-office-analysis/blob/25247fec8b1c6b23cafa389b4b7d90601e786e64/BoxOfficeAnalysis_LowBudgetAdvantage.pdf)
* `Top Movies (Cleaned Data).csv`: Raw dataset downloaded from Kaggle.
  * [**Movies Metrics, Features and Statistics by Michael Matta**](https://www.kaggle.com/datasets/michaelmatta0/movies-ultimate-metrics-features-and-metadata/data)
* `BoxOfficeFinal.csv`: Cleaned and processed dataset following SQL analysis.
* `box_office_preview.sql`: SQL query to preview dataset.
* `box_office_analysis.sql`: SQL query to select and clean data.
* `BoxOfficeAnalysis.xlsx`: Excel spreadsheet with Pivot Tables and Charts.

---
