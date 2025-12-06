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
    FROM {{ ref('int_people__employees') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['employee_id']) }} as employee_key, 
    employee_id,
    reports_to,
    employee_name,
    title,
    birth_date,
    hire_date,
    country,
    city
FROM employees