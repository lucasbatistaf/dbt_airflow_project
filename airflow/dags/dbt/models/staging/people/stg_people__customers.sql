{{ config(
    tags=['staging'],
    unique_key='customer_id'
) }}

WITH source AS (
    SELECT
        customer_id,
        company_name,
        contact_name,
        contact_title,
        country,
        city,
        address,
        phone
    FROM {{ source('PEOPLE', 'CUSTOMERS') }}
)

SELECT *
FROM source