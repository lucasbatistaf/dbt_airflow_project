{{ config(
    tags=['staging'],
    unique_key='supplier_id'
) }}

WITH source AS (
    SELECT
        supplier_id,
        company_name,
        city,
        country
    FROM {{ source('PEOPLE', 'SUPPLIERS') }}
)

SELECT *
FROM source