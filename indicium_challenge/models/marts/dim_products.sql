{{ config(
    tags=['marts_dim']
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
        category_id,
        supplier_id
    FROM {{ ref('stg_products__products')}}
),

categories AS (
    SELECT
        category_id,
        category_name
    FROM {{ ref('stg_products__categories')}}
),

suppliers AS (
    SELECT
        supplier_id,
        company_name,
        city,
        country
    FROM {{ ref('stg_products__suppliers')}}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['p.product_id']) }} as product_key, 
    p.product_id,
    p.product_name,
    c.category_name,
    s.company_name AS supplier_name,
    s.city AS supplier_city,
    s.country AS supplier_country,
    p.quantity_per_unit,
    p.unit_price,
    p.units_in_stock,
    p.units_on_order,
    p.reorder_level,
    p.discontinued
FROM products AS p
LEFT JOIN categories AS c
    ON p.category_id = c.category_id
LEFT JOIN suppliers AS s 
    ON p.supplier_id = s.supplier_id