{{ config(
    tags=['intermediate'],
    unique_key='employee_id'
) }}

WITH employees AS (
    SELECT 
        employee_id,
        reports_to,
        first_name,
        last_name,
        title,
        birth_date,
        hire_date,
        city,
        country
    FROM {{ ref('stg_people__employees') }}
)

SELECT
    employee_id,
    reports_to,
    first_name || ' ' || last_name AS employee_name,
    title,
    birth_date,
    hire_date,
    country,
    city
FROM employees