{{ config(
    tags=['intermediate'],
    unique_key='num_customer_id'
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
        phone,
        1 AS aux
    FROM {{ ref('stg_people__customers') }}
)

SELECT
    ROW_NUMBER() OVER(PARTITION BY aux ORDER BY aux) AS num_customer_id,
    customer_id AS str_customer_id,
    company_name,
    contact_name,
    contact_title,
    country,
    city,
    address,
    phone
FROM customers