{{ config(
    tags=['dimension']
) }}

WITH customers AS (
    SELECT
        customer_id,
        company_name,
        contact_name,
        contact_title,
        country,
        city,
        address,
        phone
    FROM {{ ref('stg_people__customers') }}
)

SELECT
    customer_id,
    company_name,
    contact_name,
    contact_title,
    country,
    city,
    address,
    phone
FROM customers