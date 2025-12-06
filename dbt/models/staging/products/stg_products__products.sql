{{ config(
    tags=['staging'],
    unique_key='product_id'
) }}

WITH source AS (
    SELECT
        product_id,
        product_name,
        supplier_id,
        category_id,
        quantity_per_unit,
        unit_price,
        units_in_stock,
        units_on_order,
        reorder_level,
        discontinued
    FROM {{ source('PRODUCTS', 'PRODUCTS') }}
)

SELECT *
FROM source