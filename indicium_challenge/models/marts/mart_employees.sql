{{ config(
    tags=['marts']
) }}

WITH fct_orders AS (
    SELECT 
        date_id,
        order_id,
        product_id,
        employee_id,
        quantity,
        unit_price,
        discount
    FROM {{ ref('fct_orders') }}
),

employees AS (
    SELECT 
        employee_id,
        employee_name,
        reports_to,
        country,
        city
    FROM {{ ref('dim_employees') }}
),

products AS (
    SELECT 
        product_id,
        product_name,
        category_id,
        category_name
    FROM {{ ref('dim_products') }}
),

dates AS (
    SELECT 
        date_id,
        order_date
    FROM {{ ref('dim_dates') }}
)

SELECT
    -- d.order_date,
    e.employee_id,
    e.employee_name,
    e.reports_to,
    e.country,
    e.city,
    fo.order_id,
    -- p.product_id,
    -- p.product_name,
    -- p.category_id,
    -- p.category_name,
    fo.quantity,
    fo.unit_price,
    fo.discount
FROM fct_orders AS fo
LEFT JOIN employees AS e 
    ON fo.employee_id = e.employee_id
-- LEFT JOIN products AS p
--     ON fo.product_id = p.product_id
-- LEFT JOIN dates AS d 
--     ON fo.date_id = d.date_id