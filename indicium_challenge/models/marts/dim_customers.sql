{{ config(
    tags=['dimension']
) }}

WITH customers AS (
    SELECT
        num_customer_id,
        str_customer_id,
        company_name,
        contact_name,
        contact_title,
        country,
        city,
        address,
        phone
    FROM {{ ref('int_people__customers') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['num_customer_id']) }} as customer_key, 
    num_customer_id AS customer_id,    
    str_customer_id,
    company_name,
    contact_name,
    contact_title,
    country,
    city,
    address,
    phone
FROM customers