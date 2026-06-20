/*
Question: Which skills appear most frequently in remote Data Analyst and Business Analyst jobs in 2023 and 2026?

- Extract skills from normalized skill tables for 2023.
- Search job descriptions for predefined skill keywords in 2026.
- Count occurrences of each skill.
- Rank skills within each role and year.

Why? This shows which skills are most commonly requested in the market.
*/

WITH jobs_2023 AS (
    SELECT
        '2023' AS job_year,
        job_title_short,
        job_title,
        company_id,
        job_location,
        job_via,
        job_posted_date AS job_posted_datetime,
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
        job_title,
        NULL::INT AS company_id,
        job_location,
        job_via,
        job_posted_datetime,
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
),

ranked_jobs AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY job_year, job_title_short
            ORDER BY salary_avg DESC
        ) AS rank_num
    FROM all_jobs
)

SELECT
    job_year,
    job_title_short,
    job_title,
    job_location,
    job_via,
    salary_avg
FROM ranked_jobs
WHERE rank_num <= 10
ORDER BY job_year, job_title_short, salary_avg DESC;