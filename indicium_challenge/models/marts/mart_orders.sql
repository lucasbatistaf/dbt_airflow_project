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
        shipped_date
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
    FROM {{ ref('dim_customers') }}
)

SELECT
    o.order_date,
    o.required_date,
    o.shipped_date,
    fo.order_id,
    c.customer_id,
    s.shipper_name,
    CASE
        WHEN o.shipped_date IS NULL THEN 'Processing'
        WHEN {{ datediff("shipped_date", "required_date", "day") }} >= 0 THEN 'Delivered on Time'
        WHEN {{ datediff("shipped_date", "required_date", "day") }} < 0 THEN 'Late Delivery'
    END AS delivery_classification,
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
    o.order_date, o.required_date, o.shipped_date, fo.order_id, shipper_name, c.customer_id, delivery_classification
ORDER BY
    c.customer_id, o.order_date