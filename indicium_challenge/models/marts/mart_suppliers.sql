{{ config(
    tags=['marts']
) }}

SELECT
    supplier_id,
    company_name,
    contact_name,
    contact_title,
    city,
    country,
    phone
FROM {{ ref('dim_suppliers') }}