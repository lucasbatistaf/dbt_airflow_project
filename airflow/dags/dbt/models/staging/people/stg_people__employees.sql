{{ config(
    tags=['staging'],
    unique_key='employee_id'
) }}

WITH source AS (
    SELECT
        employee_id,
        reports_to,
        first_name,
        last_name,
        first_name || ' ' || last_name AS employee_name,
        title,
        birth_date,
        hire_date,
        city,
        country
    FROM {{ source('PEOPLE', 'EMPLOYEES') }}
)

SELECT *
FROM source