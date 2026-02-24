# 📊 Inside the Numbers: Lok Sabha Elections (2014 vs 2019)

---

## 🧭 Project Overview

This project analyzes India’s 2014 and 2019 Lok Sabha election results using a strictly data-driven and neutral approach.  
Instead of prediction-led debates, the objective was to uncover measurable patterns in voter turnout, party dominance, vote swings, and structural drivers of participation.

The analysis transforms historical election data into clear, factual insights suitable for responsible media storytelling.

---

## 🎯 Problem Statement

AtliQ Media planned to telecast a show on India’s Lok Sabha Elections 2024 with a clear objective — to move away from speculation and instead present unbiased, data-backed insights.

The project aimed to:

- Analyze 2014 and 2019 election results
- Identify turnout patterns at constituency and state levels
- Examine vote-share shifts and electoral realignments
- Study structural drivers like **Per Capita NSDP (GDP proxy)** and literacy
- Present findings through clean metrics and transparent analysis

---

## 📂 Datasets Used

This project integrates multiple datasets:

- 🗳️ Lok Sabha 2014 Election Results  
- 🗳️ Lok Sabha 2019 Election Results
- 🗳️ dim_state_codes
- 📊 State-level **Per Capita NSDP** Data (GDP Proxy)  
- 📚 Literacy Data (Fetched using **Web Scraping + BeautifulSoup**)  

✅ **Note:** 2014 and 2019 election results were merged into a **single unified dataset** for comparative analysis.

📁 **Dataset Folder:**  
👉 [View Datasets Here](https://github.com/imskm732/SQL-Project/tree/0cc752028763549f3de79e95268d6f2090afc25a/Dataset)

---

## 🧾 SQL Queries

All analytical queries used for turnout analysis, vote-share comparison, margin computation, anomaly detection, and swing analysis are available below:

👉 [View SQL Query File](https://github.com/imskm732/SQL-Project/blob/2e318b1e0e04bcd944a7197b5e1ad77da56f16c3/Politcal_analysis%20setup%20and%20primary%20question%20solution.sql)

---

## 🔍 Key Insights

### 🗳️ Turnout Patterns
- High-engagement clusters remained stable (Assam & North-East).
- Jammu & Kashmir consistently recorded the lowest turnout.
- The turnout gap widened further in 2019.

### 🏆 Winners & Landslide Margins
- Certain constituencies showed repeat mandates with increasing margins.
- 2019 saw stronger concentration of landslide victories.
- 330 constituencies elected the same party consecutively.

### 🔄 Vote Share Swings
- Major realignments occurred in states like West Bengal.
- Tamil Nadu showed sharp party resurgence.
- National-level change was driven by distinct state-level shifts.

### 🚩 NOTA Analysis
- NOTA remained stable at ~5%.
- Protest voting levels did not expand significantly.
- Leading NOTA constituencies changed between elections.

### 📉 Structural Drivers of Turnout
Correlation testing showed:
- No strong relationship between **Per Capita NSDP** and turnout.
- Literacy showed only mild positive tendency.
- Postal vote % had negligible influence.

✅ Turnout appears more influenced by political competition, mobilisation, and local dynamics than structural economic indicators.

### ⚠️ Electoral Anomalies
- 37 constituencies were won by parties with <10% state-level vote share.
- Local vote concentration and alliances can override statewide popularity.

---

## 🛠 Tools & Technologies Used

- 🗄️ SQL – Data extraction, joins, aggregations  
- 🔄 Power Query – Data cleaning & transformation  
- 🐍 Python (Pandas, Matplotlib, Seaborn) – Exploratory analysis  
- 🌐 BeautifulSoup – Web scraping literacy data  
- 📊 Power BI – Visualization & storytelling  

---

## 🔄 Process Followed

1. 🎯 Defined analytical objectives  
2. 🧹 Cleaned and standardized datasets  
3. 🔗 Combined 2014 and 2019 results into a **unified dataset**  
4. ➕ Integrated **Per Capita NSDP** dataset  
5. 🌐 Scraped literacy data using **BeautifulSoup** inside the Jupyter Notebook  
6. 📊 Conducted constituency, state & national-level analysis  
7. 📈 Computed vote-share swings and winning margins  
8. 🔬 Performed correlation testing  
9. 💡 Delivered turnout-focused recommendations  

---

## 💡 Recommendations Proposed

- 🎯 Target lowest 20% turnout constituencies with localized civic programs  
- 🏢 Improve voter accessibility (polling stations, postal simplification)  
- 🎓 Strengthen civic participation awareness  
- 📍 Focus on constituency-level drivers rather than macro assumptions  

---

## 🔗 Project Links

📓 **Python Notebook:**  
👉 [Here](https://github.com/imskm732/SQL-Project/blob/0cc752028763549f3de79e95268d6f2090afc25a/Political_Analysis.ipynb)

📁 **Datasets Folder:**  
👉 [Here](https://github.com/imskm732/SQL-Project/tree/0cc752028763549f3de79e95268d6f2090afc25a/Dataset)

🧾 **SQL Query File:**  
👉 [Here](https://github.com/imskm732/SQL-Project/blob/2e318b1e0e04bcd944a7197b5e1ad77da56f16c3/Politcal_analysis%20setup%20and%20primary%20question%20solution.sql)

📽 **Presentation Video:**  
👉 [Here]()

🎥 **Presentation:**  
👉 [Here]()

🌐 **Challenge Link:**  
👉 [Here](https://codebasics.io/challenges/codebasics-resume-project-challenge/14)

---

## 👤 Role in the Project

**Junior Data Analyst**

- SQL-based analytical querying  
- Unified dataset modeling (2014 + 2019)  
- Vote-share swing computation  
- Margin & turnout analysis  
- Structural correlation testing using NSDP + literacy data  
- Visualization support  

---

## 🚀 What This Project Demonstrates

- Strong SQL analytical capability  
- Multi-source data integration (internal + scraped external data)  
- Comparative election data modeling  
- Correlation testing & hypothesis validation  
- Data storytelling for media use-cases  
- Ability to translate political datasets into neutral, evidence-based insights  

---

## 📌 Final Takeaway

This project demonstrates that election narratives can be built responsibly using historical data, measurable metrics, and transparent analysis — ensuring storytelling is driven by evidence rather than speculation.
