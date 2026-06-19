/*
Question: What are the top 10 most in-demand skills
for Data Analysts and Business Analysts?

- Join job postings with skills tables.
- Count skill demand for each role.
- Rank skills within each role.
- Return the top 10 skills for each role.
- Why? Helps compare the most valuable skills
  between Data Analyst and Business Analyst careers.
*/

WITH skill_demand AS (
    SELECT
        job_title_short,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact

    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id

    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id

    WHERE
        job_title_short IN ('Data Analyst', 'Business Analyst')
        AND job_location = 'Anywhere'

    GROUP BY
        job_title_short,
        skills_dim.skills
),

ranked_skills AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY job_title_short
            ORDER BY demand_count DESC
        ) AS rank_num
    FROM skill_demand
)

SELECT
    job_title_short,
    skills,
    demand_count
FROM ranked_skills
WHERE rank_num <= 10
ORDER BY
    job_title_short,
    demand_count DESC;

/*
[
  {
    "job_title_short": "Business Analyst",
    "skills": "sql",
    "demand_count": "1266"
  },
  {
    "job_title_short": "Business Analyst",
    "skills": "excel",
    "demand_count": "983"
  },
  {
    "job_title_short": "Business Analyst",
    "skills": "tableau",
    "demand_count": "728"
  },
  {
    "job_title_short": "Business Analyst",
    "skills": "power bi",
    "demand_count": "555"
  },
  {
    "job_title_short": "Business Analyst",
    "skills": "python",
    "demand_count": "546"
  },
  {
    "job_title_short": "Business Analyst",
    "skills": "r",
    "demand_count": "254"
  },
  {
    "job_title_short": "Business Analyst",
    "skills": "powerpoint",
    "demand_count": "246"
  },
  {
    "job_title_short": "Business Analyst",
    "skills": "word",
    "demand_count": "213"
  },
  {
    "job_title_short": "Business Analyst",
    "skills": "sas",
    "demand_count": "208"
  },
  {
    "job_title_short": "Business Analyst",
    "skills": "azure",
    "demand_count": "196"
  },
  {
    "job_title_short": "Data Analyst",
    "skills": "sql",
    "demand_count": "7291"
  },
  {
    "job_title_short": "Data Analyst",
    "skills": "excel",
    "demand_count": "4611"
  },
  {
    "job_title_short": "Data Analyst",
    "skills": "python",
    "demand_count": "4330"
  },
  {
    "job_title_short": "Data Analyst",
    "skills": "tableau",
    "demand_count": "3745"
  },
  {
    "job_title_short": "Data Analyst",
    "skills": "power bi",
    "demand_count": "2609"
  },
  {
    "job_title_short": "Data Analyst",
    "skills": "r",
    "demand_count": "2142"
  },
  {
    "job_title_short": "Data Analyst",
    "skills": "sas",
    "demand_count": "1866"
  },
  {
    "job_title_short": "Data Analyst",
    "skills": "looker",
    "demand_count": "868"
  },
  {
    "job_title_short": "Data Analyst",
    "skills": "azure",
    "demand_count": "821"
  },
  {
    "job_title_short": "Data Analyst",
    "skills": "powerpoint",
    "demand_count": "819"
  }
]
/*