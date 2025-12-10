{{ config(
    tags=['marts']
) }}

WITH fct_orders AS (
    SELECT 
        date_id,
        order_id,
        customer_id,
        shipper_id,
        quantity,
        unit_price,
        discount
    FROM {{ ref('fct_orders') }}
),

orders AS (
    SELECT
        order_date,
        order_id,
        required_date,
        shipped_date,
        delivery_classification,
        days_to_delivery
    FROM {{ ref('dim_orders') }}
),

shippers AS (
    SELECT 
        shipper_id,
        shipper_name,
    FROM {{ ref('dim_shippers') }}
),

customers AS (
    SELECT 
        customer_id,
        country
    FROM {{ ref('dim_customers') }}
)

SELECT
    o.order_date,
    o.required_date,
    o.shipped_date,
    fo.order_id,
    c.customer_id,
    c.country AS customer_country,
    s.shipper_name,
    o.delivery_classification,    
    o.days_to_delivery,
    SUM(fo.quantity) AS product_qty,
    SUM(fo.unit_price) AS order_price,
    SUM(fo.discount) AS order_discount,
    DATEDIFF('day', LAG(o.order_date) OVER(PARTITION BY c.customer_id ORDER BY o.order_date), o.order_date) AS order_date_diff
FROM fct_orders AS fo
LEFT JOIN orders AS o
    ON fo.order_id = o.order_id
LEFT JOIN shippers AS s 
    ON fo.shipper_id = s.shipper_id
LEFT JOIN customers AS c 
    ON fo.customer_id = c.customer_id
GROUP BY
    o.order_date, o.required_date, o.shipped_date, fo.order_id, shipper_name, c.customer_id, c.country, o.delivery_classification, o.days_to_delivery