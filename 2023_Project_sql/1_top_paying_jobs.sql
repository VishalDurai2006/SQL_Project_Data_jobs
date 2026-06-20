/*
Question: What are the top paying data analyst and business analyst jobs?
-Identify the top 10 high paying jobs for data analysts and business analysts.
-Focusing on job postings with specific salary (Removing Nulls)
-Why? Higlight the the top paying opportunities for data analyst and business analyst and gain insight to find optimal skills to learn
*/

WITH ranked_jobs AS (
    SELECT
        company_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_title_short,
        ROW_NUMBER() OVER (S
            PARTITION BY job_title_short
            ORDER BY salary_year_avg DESC
        ) AS rank_num
    FROM job_postings_fact
    WHERE job_title_short IN ('Data Analyst', 'Business Analyst')
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'
)

SELECT
    ranked_jobs.job_title_short,
    ranked_jobs.job_title,
    ranked_jobs.job_location,
    ranked_jobs.job_schedule_type,
    ranked_jobs.salary_year_avg,
    company_dim.name AS company_name
FROM ranked_jobs
LEFT JOIN company_dim
    ON ranked_jobs.company_id = company_dim.company_id
WHERE rank_num <= 10
ORDER BY job_title_short, salary_year_avg DESC;