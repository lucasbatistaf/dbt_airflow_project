{{ config(
    tags=['intermediate']
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
        CASE
            WHEN shipped_date IS NULL THEN 'Processing'
            WHEN {{ datediff("shipped_date", "required_date", "day") }} >= 0 THEN 'Delivered on Time'
            WHEN {{ datediff("shipped_date", "required_date", "day") }} < 0 THEN 'Late Delivery'
        END AS delivery_classification,
        DATEDIFF('day', order_date, shipped_date) AS days_to_delivery
    FROM {{ ref('stg_orders__orders') }}
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