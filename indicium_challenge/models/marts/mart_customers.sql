{{ config(
    tags=['marts']
) }}

SELECT
    customer_id,
    company_name,
    contact_name,
    contact_title,
    country,
    city,
    order_id
FROM {{ ref('dim_customers') }}