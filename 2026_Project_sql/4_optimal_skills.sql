/*
Question: Which skills have BOTH high demand and high salaries in 2026?

- Scan remote DA and BA job descriptions for a curated skill list.
- Measure both demand and average salary for each skill.
- Rank skills by demand first, then salary.
- Return the top 25 skills for each role.
- Why? This identifies the best skills to learn for both market demand and pay.
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
skill_balance AS (
    SELECT
        job_title_short,
        skill,
        COUNT(*) AS demand_count,
        ROUND(AVG(salary_avg), 0) AS avg_salary
    FROM matched_skills
    GROUP BY
        job_title_short,
        skill
    HAVING COUNT(*) >= 5
),
ranked_skills AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY job_title_short
            ORDER BY demand_count DESC, avg_salary DESC
        ) AS rank_num
    FROM skill_balance
)

SELECT
    job_title_short,
    skill,
    demand_count,
    avg_salary
FROM ranked_skills
WHERE rank_num <= 25
ORDER BY
    job_title_short,
    demand_count DESC,
    avg_salary DESC;