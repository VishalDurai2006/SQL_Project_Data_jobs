/*
Question: Which skills overlap and which are unique between Data Analyst and Business Analyst roles?

- Compare the same skill list across both roles.
- Show demand by role side by side.
- Show average salary by role side by side.
- Why? This makes the project more original and shows how the two career paths differ.
*/

WITH skills_list(skill) AS (
    VALUES
        ('sql'),
        ('python'),
        ('excel'),
        ('tableau'),
        ('power bi'),
        ('looker'),
        ('r'),
        ('sas'),
        ('spss'),
        ('snowflake'),
        ('bigquery'),
        ('aws'),
        ('azure'),
        ('gcp'),
        ('databricks'),
        ('spark'),
        ('pandas'),
        ('statistics'),
        ('business intelligence'),
        ('data visualization'),
        ('reporting'),
        ('dashboard'),
        ('communication'),
        ('requirements gathering'),
        ('stakeholder management')
),
matched_skills AS (
    SELECT
        j.job_title_short,
        s.skill,
        j.salary_avg
    FROM datanerd.jobs_2026 j
    CROSS JOIN skills_list s
    WHERE j.job_title_short IN ('Data Analyst', 'Business Analyst')
        AND j.salary_avg IS NOT NULL
        AND j.job_location = 'Anywhere'
        AND j.job_description ILIKE '%' || s.skill || '%'
)

SELECT
    skill,
    SUM(CASE WHEN job_title_short = 'Data Analyst' THEN 1 ELSE 0 END) AS Data_Analyst_demand,
    SUM(CASE WHEN job_title_short = 'Business Analyst' THEN 1 ELSE 0 END) AS Business_Analyst_demand,
    ROUND(AVG(CASE WHEN job_title_short = 'Data Analyst' THEN salary_avg END), 0) AS Data_Analyst_avg_salary,
    ROUND(AVG(CASE WHEN job_title_short = 'Business Analyst' THEN salary_avg END), 0) AS Business_Analyst_avg_salary
FROM matched_skills
GROUP BY skill
ORDER BY
    GREATEST(
        SUM(CASE WHEN job_title_short = 'Data Analyst' THEN 1 ELSE 0 END),
        SUM(CASE WHEN job_title_short = 'Business Analyst' THEN 1 ELSE 0 END)
    ) DESC,
    skill;