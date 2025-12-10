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
        ship_country,
        delivery_classification,
        days_to_delivery
    FROM {{ ref('int_orders__orders') }}
)

SELECT
    order_date,
    order_id,
    required_date,
    shipped_date,
    freight,
    ship_name,
    ship_city,
    ship_country,
    delivery_classification,
    days_to_delivery
FROM orders