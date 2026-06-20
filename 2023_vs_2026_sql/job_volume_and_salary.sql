/*
Question: How did job volume and average salary change between 2023 and 2026 for remote Data Analyst and Business Analyst roles?

- Combine 2023 and 2026 job datasets.
- Count total jobs for each role and year.
- Calculate average salary for each role and year.
- Compare demand and compensation trends.

Why? This shows whether the market for DA and BA roles grew, shrank, or changed in salary over time.
*/

WITH jobs_2023 AS (
    SELECT
        '2023' AS job_year,
        job_title_short,
        salary_year_avg AS salary_avg
    FROM job_postings_fact
    WHERE job_title_short IN ('Data Analyst', 'Business Analyst')
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'
),

jobs_2026 AS (
    SELECT
        '2026' AS job_year,
        job_title_short,
        salary_avg
    FROM datanerd.jobs_2026
    WHERE job_title_short IN ('Data Analyst', 'Business Analyst')
        AND salary_avg IS NOT NULL
        AND job_location = 'Anywhere'
),

all_jobs AS (
    SELECT * FROM jobs_2023
    UNION ALL
    SELECT * FROM jobs_2026
)

SELECT
    job_year,
    job_title_short,
    COUNT(*) AS job_count,
    ROUND(AVG(salary_avg), 0) AS avg_salary
FROM all_jobs
GROUP BY job_year, job_title_short
ORDER BY job_year, job_title_short;