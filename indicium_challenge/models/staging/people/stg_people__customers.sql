{{ config(
    tags=['staging'],
    unique_key='str_customer_id'
) }}

WITH source AS (
    SELECT
        customer_id,
        1 AS aux,
        company_name,
        city,
        country
    FROM {{ source('PEOPLE', 'CUSTOMERS') }}
)

SELECT 
    ROW_NUMBER() OVER(PARTITION BY aux ORDER BY aux) AS num_customer_id,
    customer_id AS str_customer_id,
    company_name,
    city,
    country
FROM source