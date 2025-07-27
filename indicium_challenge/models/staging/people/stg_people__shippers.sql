{{ config(
    tags=['staging'],
    unique_key='shipper_id'
) }}

WITH source AS (
    SELECT
        shipper_id,
        company_name,
        phone
    FROM {{ source('PEOPLE', 'SHIPPERS') }}
)

SELECT *
FROM source