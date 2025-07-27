{{ config(
    tags=['fact']
) }}

WITH order_details AS (
    SELECT 
        order_id,
        product_id,
        quantity,
        unit_price,
        discount
    FROM {{ ref('stg_orders__order_details') }}
),

customers AS (
    SELECT
        customer_id,
        order_id
    FROM {{ ref('dim_customers') }}
),

dates AS (
    SELECT
        date_id,
        order_id
    FROM {{ ref('dim_dates') }}
),

employees AS (
    SELECT
        employee_id,
        order_id
    FROM {{ ref('dim_employees') }}
),

orders AS (
    SELECT
        order_id
    FROM {{ ref('dim_orders') }}
),

products AS (
    SELECT
        product_id
    FROM {{ ref('dim_products') }}
),

shippers AS (
    SELECT
        shipper_id,
        order_id
    FROM {{ ref('dim_shippers') }}
),

suppliers AS (
    SELECT
        supplier_id,
        product_id
    FROM {{ ref('dim_suppliers') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['d.date_id', 'od.order_id', 'od.product_id']) }} as fct_order_key, 
    d.date_id,
    od.order_id,
    od.product_id,
    c.customer_id,
    e.employee_id,
    sh.shipper_id,
    su.supplier_id,
    od.quantity,
    od.unit_price,
    od.discount
FROM order_details AS od
LEFT JOIN customers AS c
    ON od.order_id = c.order_id
LEFT JOIN dates AS d
    ON od.order_id = d.order_id
LEFT JOIN employees AS e
    ON od.order_id = e.order_id
LEFT JOIN orders AS o
    ON od.order_id = o.order_id
LEFT JOIN products AS p
    ON od.product_id = p.product_id
LEFT JOIN shippers AS sh
    ON sh.order_id = o.order_id
LEFT JOIN suppliers AS su
    ON su.product_id = p.product_id