{{ config(
    tags=['fact']
) }}

WITH products AS (
    SELECT
        product_id,
        supplier_id
    FROM {{ ref('stg_products__products') }}
),

orders AS (
    SELECT
        REPLACE(order_date, '-', '') AS date_id,
        order_id,
        customer_id,
        employee_id,
        ship_via AS shipper_id
    FROM {{ ref('stg_orders__orders') }}
),

order_details AS (
    SELECT 
        o.date_id,
        od.order_id,
        od.product_id,
        p.supplier_id,
        o.customer_id,
        o.employee_id,
        o.shipper_id,
        od.quantity,
        od.unit_price,
        od.discount
    FROM {{ ref('stg_orders__order_details') }} AS od
    LEFT JOIN products AS p 
        ON od.product_id = p.product_id
    LEFT JOIN orders AS o 
        ON od.order_id = o.order_id
),

customers AS (
    SELECT
        customer_id
    FROM {{ ref('dim_customers') }}
),

dates AS (
    SELECT
        date_id,
        order_date
    FROM {{ ref('dim_dates') }}
),

employees AS (
    SELECT
        employee_id
    FROM {{ ref('dim_employees') }}
),

shippers AS (
    SELECT
        shipper_id
    FROM {{ ref('dim_shippers') }}
),

suppliers AS (
    SELECT
        supplier_id
    FROM {{ ref('dim_suppliers') }}
)

SELECT
    od.date_id,
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
    ON od.customer_id = c.customer_id
LEFT JOIN employees AS e
    ON od.employee_id = e.employee_id
LEFT JOIN shippers AS sh
    ON od.shipper_id = sh.shipper_id
LEFT JOIN suppliers AS su
    ON od.supplier_id = su.supplier_id