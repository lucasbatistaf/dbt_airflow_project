{{ config(
    tags=['dimension']
) }}

WITH source AS (
    SELECT
        REPLACE(order_date, '-', '') AS date_id,
        order_date AS order_date
    FROM  {{ ref('stg_orders__orders') }}
)

SELECT
    date_id,
    order_date
FROM source