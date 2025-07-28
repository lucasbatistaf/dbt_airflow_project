{{ config(
    tags=['marts']
) }}

WITH fct_orders AS (
    SELECT 
        date_id,
        order_id,
        product_id,
        supplier_id,
        shipper_id,
        quantity,
        unit_price,
        discount
    FROM {{ ref('fct_orders') }}
),

suppliers AS (
    SELECT 
        supplier_id,
        supplier_name,
        supplier_city,
        supplier_country,
    FROM {{ ref('dim_suppliers') }}
),

shippers AS (
    SELECT 
        shipper_id,
        shipper_name,
    FROM {{ ref('dim_shippers') }}
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
    d.order_date,
    fo.order_id,
    p.product_id,
    p.product_name,
    p.category_id,
    p.category_name,
    su.supplier_id,
    su.supplier_name,
    su.supplier_city,
    su.supplier_country,
    sh.shipper_id,
    sh.shipper_name,
    fo.quantity,
    fo.unit_price,
    fo.discount
FROM fct_orders AS fo
LEFT JOIN shippers AS sh 
    ON fo.shipper_id = sh.shipper_id
LEFT JOIN suppliers AS su 
    ON fo.supplier_id = su.supplier_id
LEFT JOIN products AS p
    ON fo.product_id = p.product_id
LEFT JOIN dates AS d 
    ON fo.date_id = d.date_id