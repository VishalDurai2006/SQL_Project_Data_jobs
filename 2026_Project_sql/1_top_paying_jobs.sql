/*
Question: What are the highest paying remote Data Analyst and Business Analyst jobs in 2026?

- Keep only remote jobs (job_location = 'Anywhere').
- Keep only jobs with a known salary (Removing Nulls).
- Rank jobs separately for Data Analyst and Business Analyst.
- Return the top 10 for each role.
- Why? This shows the best-paying remote opportunities in the 2026 market.
*/

WITH ranked_jobs AS (
    SELECT
        job_id,
        job_title_short,
        job_title,
        company_name,
        job_country,
        job_location,
        job_via,
        job_posted_datetime,
        salary_avg,
        ROW_NUMBER() OVER (
            PARTITION BY job_title_short
            ORDER BY salary_avg DESC, job_posted_datetime DESC
        ) AS rank_num
    FROM datanerd.jobs_2026
    WHERE job_title_short IN ('Data Analyst', 'Business Analyst')
        AND salary_avg IS NOT NULL
        AND job_location = 'Anywhere'
)

SELECT
    job_title_short,
    job_title,
    company_name,
    job_country,
    job_location,
    job_via,
    job_posted_datetime,
    salary_avg
FROM ranked_jobs
WHERE rank_num <= 10
ORDER BY job_title_short, salary_avg DESC, job_posted_datetime DESC;