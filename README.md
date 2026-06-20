# Data & Business Analyst Job Market Analysis: 2023 vs. 2026 Evolution

![Dashboard with four horizontal bar charts comparing top skills for Data Analyst and Business Analyst roles in 2023 and 2026, titled SKILL COUNT EVOLUTION 2023 vs 2026 DATA ANALYST vs BUSINESS ANALYST, on a dark background showing frequencies and chart labels](image.png)

## Introduction
Welcome to my Data Portfolio project. This repository evaluates the changing dynamics of the global remote job market for **Data Analysts (DA)** and **Business Analysts (BA)**. By querying and cleaning real-world job posting records spanning **2023 through 2026**, this project tracks structural changes in hiring volume, compensation trajectories, core technical dependencies, and the impact of automation.

Rather than a basic academic query showcase, this project serves as a data-driven market research piece, illustrating how analytics expectations have adapted over a three-year timeline.

---

## Background
The motivation behind this project stems from a simple diagnostic question: **"Which technical skills actually move the needle for high-paying roles, and how has that target changed over time?"** As data teams mature and AI engines commoditize exploratory pipelines, the baseline requirements for entering both paths have changed. This project isolates:
* The absolute top-paying opportunities and historical salary ceilings.
* The baseline data stack tools dominating total job posting volume (Market Demand).
* The cross-over sweet spot where high volume intersects top-tier compensation (Optimal Skills).
* A concrete evaluation of the market shifts between 2023 and 2026.

---

## Tools I Used
* **SQL (PostgreSQL):** The core analytical engine. Utilized Common Table Expressions (CTEs), window functions (`ROW_NUMBER()`), CASE expressions, aggregations, and subqueries to shape raw data.
* **VS Code:** My environment for constructing structured scripts and compiling documentation.
* **Excel:** Imported tabular data into the data bases and they are `job_postings_fact.csv`, `company_dim.csv`, `skills_dim.csv`, `skills_job_dim.csv` and `all_jobs_2026` sheets.


---

## The Analysis
Each segment below maps directly to active production scripts located inside this workspace.

### 1. Top-Paying Jobs (2023 vs. 2026)
* **Objective:** Identify the highest absolute salary ceilings for both roles while eliminating null entries.
* **Key Findings:** 
  * In **2023**, Data Analyst salaries peaked spectacularly, led by a breakout technical role at *Mantys* ($650,000) and enterprise analytics leadership roles at *Meta* ($336,500). Business Analyst roles peaked slightly lower but stably, led by *Noom* ($220,000) and *Uber* ($214,500).
  * In **2026**, the absolute ceiling compressed slightly to adjust for macro market corrections, yet premium specializations emerged. For example, a specialized **Data Analyst - Analysis & Reporting (z Platform/Mainframe)** hit a notable outlier ceiling in local markets, while **Business Analyst with AI Experience ($142,500)** set the structural standard for modern business planning.

### 2. Market Demand: Most In-Demand Skills (2023 Baseline)
* **Objective:** Determine which baseline tools appear most frequently across all posted openings to understand true market volume.
* **Data Visual Summary:**

| Job Title Short | Skill Name | 2023 Posting Volume |
| :--- | :--- | :--- |
| **Data Analyst** | SQL | 7,291 posts |
| **Data Analyst** | Excel | 4,611 posts |
| **Data Analyst** | Python | 4,330 posts |
| **Data Analyst** | Tableau | 3,745 posts |
| **Business Analyst** | SQL | 1,266 posts |
| **Business Analyst** | Excel | 983 posts |
| **Business Analyst** | Tableau | 728 posts |

* **Takeaway:** Regardless of role bifurcation, **SQL** and **Excel** remain the absolute non-negotiable floor for entering the modern data ecosystem.

### 3. Skills Premium: Top-Paying Skills
* **Objective:** Identify which unique skills are tied to the highest average annual salaries, irrespective of volume.
* **Insight:** For Business Analysts, specialized engineering and cloud data orchestration pipelines paid maximum premiums (**Hadoop** averaged **$139,201**, **Airflow** commanded **$135,410**, and **Snowflake** sat at **$112,543**). This proves that technical data-engineering adjacencies carry significant salary premiums over pure business reporting.

### 4. Optimal Skills (High Demand + High Pay)
* **Objective:** Locate the intersecting sweet spot. Which high-volume skills actively preserve high average salaries?
* **Analysis Summary:**
  * For **Data Analysts**, the gold standards are clear: **Python ($101,397 avg)** and **Tableau ($99,288 avg)** balance widespread adoption with top-shelf compensation.
  * For **Business Analysts**, **Python ($116,516 avg)** and **Tableau ($104,233 avg)** provide immediate financial leverage over pure Excel-centric roles.

### 5. Salary Evolution: 2023 vs. 2026
* **Objective:** Measure how average compensation shifted over time for remote Data Analyst and Business Analyst roles.
* **Core Comparison Metrics:**

| Role Title | 2023 Avg Salary | 2026 Avg Salary | Growth Change |
| :--- | :--- | :--- | :--- |
| **Data Analyst** | $102,211 | $115,317 | **+12.8%** |
| **Business Analyst** | $93,296 | $103,280 | **+10.7%** |

* **Key Insights:** Both roles experienced positive structural salary growth over the 3-year window, with Data Analyst salaries advancing slightly faster due to escalating technical complexity. 

---

## Impact of AI on Analyst Roles
Observations from the newer 2026 dataset indicate that AI is **not replacing analysts**; rather, it is actively shifting the baseline skill expectations:
* **Tasks Increasingly Automated by AI:** Dashboard generation templates, report drafting, basic SQL generation, and automated cleaning routines.
* **Skills Rising in Earning Power:** High-level human skills including **Data Storytelling**, **Business Communication**, **Prompt Engineering**, and building pipelines directly through **SQL/Python** cloud interfaces. 
* Roles explicitly calling for AI integrations, such as the *Business Analyst with AI Experience* position discovered in 2026, are establishing the framework for future enterprise planning salaries.

---

## Project Limitations
To ensure complete analytical honesty, several structural constraints in the underlying data should be noted:
* **2023 Dataset:** Utilizes highly reliable, explicitly normalized skill mapping tables (`skills_dim` and `skills_job_dim`), providing complete exact counts.
* **2026 Dataset:** Does not feature a normalized relational skill mapping schema. Skills were parsed directionally using case-insensitive keyword filtering (`ILIKE '%python%'`) inside long-text job descriptions. As a result, counts are directional rather than exact.
* **Salary Availability Filter:** A massive percentage of job boards omit salary values. To ensure analytical accuracy, a strict `WHERE salary_avg IS NOT NULL` constraint was applied across all compensation queries. Therefore, comparisons represent trends among *salary-disclosed jobs* rather than the full absolute market.

---

## What I Learned
Through designing and tuning these SQL queries, I solidified three strategic data concepts:
1. **Advanced Query Strategy:** Writing clean CTEs is essential. Separating filtering logic from structural window rank calculations keeps execution plans readable and optimized.
2. **The "Specialization Premium":** The data demonstrates that generalized reporting skills are commoditizing. The real financial upside sits squarely at the crossroads of Data Analytics and foundational Engineering/Cloud platforms (Snowflake, AWS, Airflow).
3. **The Rise of Modern Business Roles:** Business alignment now explicitly requires AI literacy. Moving forward, the most valuable professionals are those bridging data infrastructure with business execution.

---

## Final Conclusions
This project demonstrates that despite rapid technological changes and the rise of automated engines, **SQL remains the most valuable foundational skill** across both career paths.

### The Data Analyst Path
* **Most Valuable Stack:** `SQL` + `Python` + `Tableau/Power BI` + `Cloud Data Tools (Snowflake/AWS)` + `Statistics`.
* Salary growth tracks upward for analysts migrating closer to engineering tasks.

### The Business Analyst Path
* **Most Valuable Stack:** `SQL` + `Excel` + `Tableau/Power BI` + `Stakeholder Communication`.
* Business Analysts are becoming increasingly data-driven, maintaining client-facing functions while acting as the bridge for AI integration.

### Overall Market Direction
The analyst market is transitioning away from manual, repetitive data reporting and heavily prioritizing **Insight Generation** and **AI-Assisted Analysis**. The strongest future candidates will combine traditional relational core query skills with business domain authority and strong AI literacy.