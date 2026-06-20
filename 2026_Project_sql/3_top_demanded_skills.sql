/*
Question: Which skills appear most frequently in remote DA and BA jobs in 2026?

- Scan remote DA and BA job descriptions for a curated skill list.
- Count how often each skill appears.
- Rank skills within each role.
- Return the top 25 skills for each role.
- Why? This shows which skills are most commonly requested in the market.
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
        AND j.job_location = 'Anywhere'
        AND j.job_description ILIKE '%' || s.skill || '%'
),
skill_demand AS (
    SELECT
        job_title_short,
        skill,
        COUNT(*) AS demand_count,
        ROUND(AVG(salary_avg), 0) AS avg_salary
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
            ORDER BY demand_count DESC, avg_salary DESC
        ) AS rank_num
    FROM skill_demand
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