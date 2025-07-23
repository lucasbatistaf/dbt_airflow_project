{{ config(
    tags=['staging']
) }}

WITH source AS (
    SELECT 
        order_id,
        product_id,
        quantity,
        unit_price,
        discount
    FROM {{ source('ORDERS', 'ORDER_DETAILS') }}
)

SELECT *
FROM source;