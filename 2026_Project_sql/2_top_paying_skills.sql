/*
Question: Which skills are associated with the highest salaries in 2026?

- Scan remote DA and BA job descriptions for a curated skill list.
- Calculate the average salary for each skill mention.
- Rank skills within each role.
- Return the top 25 skills for each role.
- Why? This identifies skills that may lead to the highest-paying roles.
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
),
skill_salary AS (
    SELECT
        job_title_short,
        skill,
        ROUND(AVG(salary_avg), 0) AS avg_salary,
        COUNT(*) AS demand_count
    FROM matched_skills
    GROUP BY
        job_title_short,
        skill
),
ranked_skills AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY job_title_short
            ORDER BY avg_salary DESC, demand_count DESC
        ) AS rank_num
    FROM skill_salary
)

SELECT
    job_title_short,
    skill,
    avg_salary,
    demand_count
FROM ranked_skills
WHERE rank_num <= 25
ORDER BY
    job_title_short,
    avg_salary DESC,
    demand_count DESC;