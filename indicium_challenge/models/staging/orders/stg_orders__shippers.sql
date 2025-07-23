{{ config(
    tags=['staging'],
    unique_key='shipper_id'
) }}

WITH source AS (
    SELECT
        shipper_id,
        company_name
    FROM {{ source('ORDERS', 'SHIPPERS') }}
)

SELECT *
FROM source