{{ config(
    tags=['staging'],
    unique_key='order_id'
) }}

WITH source AS (
    SELECT
        order_date,
        order_id,
        customer_id,
        employee_id,
        ship_via,
        required_date,
        shipped_date,
        freight,
        ship_name,
        ship_city,
        ship_country
    FROM {{ source('ORDERS', 'ORDERS') }}
)

SELECT *
FROM source