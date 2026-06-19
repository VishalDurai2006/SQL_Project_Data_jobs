/*
Compare optimal skills for
Data Analysts and Business Analysts
*/

SELECT
    job_postings_fact.job_title_short,
    skills_dim.skills,
    COUNT(*) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact

INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id

INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE
    job_postings_fact.job_title_short IN
    ('Data Analyst','Business Analyst')
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_location = 'Anywhere'

GROUP BY
    job_postings_fact.job_title_short,
    skills_dim.skills

HAVING COUNT(*) > 10

ORDER BY
    job_postings_fact.job_title_short,
    demand_count DESC,
    avg_salary DESC;