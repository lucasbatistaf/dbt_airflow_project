{{ config(
    tags=['dimension']
) }}

WITH orders AS (
    SELECT            
        order_date,
        order_id,
        required_date,
        shipped_date,
        freight,
        ship_name,
        ship_city,
        ship_country
    FROM {{ ref('stg_orders__orders') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['o.order_id']) }} as order_key, 
    o.order_date,
    o.order_id,
    o.required_date,
    o.shipped_date,
    o.freight,
    o.ship_name,
    o.ship_city,
    o.ship_country
FROM orders AS o