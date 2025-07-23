{{ config(
    tags=['marts_dim']
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
        ship_country,
        ship_via,
        customer_id,
        employee_id
    FROM {{ ref('stg_orders__orders') }}
),

shippers AS (
    SELECT
        shipper_id,
        company_name
    FROM {{ ref('stg_orders__shippers') }}
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
    o.ship_country,
    s.company_name AS shipper_name
FROM orders AS o 
LEFT JOIN shippers AS s
    ON o.ship_via = s.shipper_id