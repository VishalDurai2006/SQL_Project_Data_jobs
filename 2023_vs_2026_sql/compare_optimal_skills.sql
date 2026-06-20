/*
Question: Which skills provide the best combination of demand and salary for remote DA and BA jobs in 2023 and 2026?

- Count how often each skill appears.
- Calculate average salary associated with each skill.
- Compare skill demand and salary together.
- Rank valuable skills by market demand and compensation.

Why? This identifies the most valuable skills to learn based on both popularity and earning potential.
*/

WITH skill_list AS (
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

skills_2023 AS (
    SELECT
        '2023' AS job_year,
        j.job_title_short,
        sd.skills AS skill,
        COUNT(*) AS demand_count,
        ROUND(AVG(j.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact j
    INNER JOIN skills_job_dim sjd
        ON j.job_id = sjd.job_id
    INNER JOIN skills_dim sd
        ON sjd.skill_id = sd.skill_id
    WHERE j.job_title_short IN ('Data Analyst', 'Business Analyst')
        AND j.salary_year_avg IS NOT NULL
        AND j.job_location = 'Anywhere'
    GROUP BY j.job_title_short, sd.skills
),

skills_2026 AS (
    SELECT
        '2026' AS job_year,
        j.job_title_short,
        s.column1 AS skill,
        COUNT(*) AS demand_count,
        ROUND(AVG(j.salary_avg), 0) AS avg_salary
    FROM datanerd.jobs_2026 j
    CROSS JOIN skill_list s
    WHERE j.job_title_short IN ('Data Analyst', 'Business Analyst')
        AND j.salary_avg IS NOT NULL
        AND j.job_location = 'Anywhere'
        AND j.job_description ILIKE '%' || s.column1 || '%'
    GROUP BY j.job_title_short, s.column1
),

all_skills AS (
    SELECT * FROM skills_2023
    UNION ALL
    SELECT * FROM skills_2026
)

SELECT
    job_year,
    job_title_short,
    skill,
    demand_count,
    avg_salary
FROM all_skills
ORDER BY
    job_year,
    job_title_short,
    demand_count DESC,
    avg_salary DESC;