{{ config(
    tags=['dimension']
) }}

WITH employees AS (
    SELECT
        *
    FROM {{ ref('int_people__employees') }}
),

orders AS (
    SELECT
        order_id,
        employee_id
    FROM {{ ref('stg_orders__orders') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['e.employee_id', 'o.order_id']) }} as employee_key, 
    e.employee_id,
    e.reports_to,
    e.employee_name,
    e.title,
    e.birth_date,
    e.hire_date,
    e.country,
    e.city,
    o.order_id
FROM employees AS e
LEFT JOIN orders AS o 
    ON e.employee_id = o.employee_id