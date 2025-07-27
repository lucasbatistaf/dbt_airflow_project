{{ config(
    tags=['dimension']
) }}

WITH shippers AS (
    SELECT
        shipper_id,
        company_name,
        phone
    FROM {{ ref('stg_people__shippers') }}
),

orders AS (
    SELECT
        order_id,
        ship_via
    FROM {{ ref('stg_orders__orders') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['s.shipper_id', 'o.order_id']) }} as shipper_key, 
    s.shipper_id,
    s.company_name,
    s.phone
FROM shippers AS s
LEFT JOIN orders AS o 
    ON s.shipper_id = o.ship_via