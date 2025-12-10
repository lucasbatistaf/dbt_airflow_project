{{ config(
    tags=['dimension']
) }}

WITH products AS (
    SELECT
        product_id,
        product_name,
        quantity_per_unit,
        unit_price,
        units_in_stock,
        units_on_order,
        reorder_level,
        discontinued,
        category_id
    FROM {{ ref('stg_products__products')}}
),

categories AS (
    SELECT
        category_id,
        category_name
    FROM {{ ref('stg_products__categories')}}
)

SELECT
    p.product_id,
    p.product_name,
    c.category_id,
    c.category_name,
    p.quantity_per_unit,
    p.unit_price,
    p.units_in_stock,
    p.units_on_order,
    p.reorder_level,
    p.discontinued
FROM products AS p
LEFT JOIN categories AS c
    ON p.category_id = c.category_id