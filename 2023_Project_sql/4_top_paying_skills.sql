/*
Question:
What are the highest-paying skills for
Data Analysts and Business Analysts?

Compare average salaries by skill.
*/

SELECT
    job_postings_fact.job_title_short,
    skills_dim.skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary,
    COUNT(*) AS job_count
FROM job_postings_fact

INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id

INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE
    job_postings_fact.job_title_short IN
    ('Data Analyst', 'Business Analyst')
    AND job_postings_fact.salary_year_avg IS NOT NULL

GROUP BY
    job_postings_fact.job_title_short,
    skills_dim.skills

HAVING COUNT(*) >= 5

ORDER BY
    job_postings_fact.job_title_short,
    avg_salary DESC;

/*
Business Analyst Analysis
Highest Paying Skills
Skill	Avg Salary	Demand
Hadoop	$139k	14
Airflow	$135k	6
Phoenix	$135k	16
C	$123k	7
NoSQL	$119k	11

These skills pay well but demand is relatively low.

Interpretation

This suggests that the highest-paying BA jobs are increasingly blending into:

Data Engineering
Cloud Analytics
Enterprise Data Platforms

Traditional BA skills alone are not producing the highest salaries.

Most Valuable BA Skills

Looking at both salary and demand:

Skill	Avg Salary	Demand
SQL	$95k	312
Tableau	$99k	212
Excel	$87k	226
Python	$104k	143
Power BI	$92k	139
R	$106k	73
SAS	$100k	74
Conclusion

For a Business Analyst in 2026:

SQL
Tableau
Excel
Power BI
Python

are the core skills.

Data Analyst Analysis
Highest Paying Skills
Skill	Avg Salary	Demand
GitLab	$134k	7
Kafka	$130k	40
PyTorch	$125k	20
Perl	$125k	20
TensorFlow	$121k	24

These are no longer traditional analytics skills.

They indicate movement toward:

Machine Learning
Data Engineering
AI Infrastructure
Most Valuable Data Analyst Skills

Looking at both salary and demand:

Skill	Avg Salary	Demand
SQL	        $96k	3083
Excel	    $86k	2143
Python	    $102k	1840
Tableau	    $98k	1659
R	        $99k	1073
Power BI	$92k	1044
SAS	        $94k	1000

These dominate the market.

Direct Comparison
Skill	Data Analyst Demand	Business Analyst Demand
SQL	3083	312
Python	1840	143
Tableau	1659	212
Power BI	1044	139
Excel	2143	226
Insight

Data Analysts require significantly more technical skills than Business Analysts.

Business Analysts focus on:

Business processes
Stakeholder management
Reporting
Requirements gathering

Data Analysts focus on:

Data extraction
Analysis
Visualization
Statistics
Programming
/*