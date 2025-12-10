{{ config(
    tags=['dimension']
) }}

WITH employees AS (
    SELECT
        employee_id,
        reports_to,
        employee_name,
        title,
        birth_date,
        hire_date,
        country,
        city
    FROM {{ ref('stg_people__employees') }}
)

SELECT
    employee_id,
    reports_to,
    employee_name,
    title,
    birth_date,
    hire_date,
    country,
    city
FROM employees