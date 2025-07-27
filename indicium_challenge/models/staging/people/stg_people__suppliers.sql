{{ config(
    tags=['staging'],
    unique_key='supplier_id'
) }}

WITH source AS (
    SELECT
        supplier_id,
        company_name,
        contact_name,
        contact_title,
        city,
        country,
        phone
    FROM {{ source('PEOPLE', 'SUPPLIERS') }}
)

SELECT *
FROM source