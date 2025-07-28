{{ config(
    tags=['dimension']
) }}

WITH supplier AS (
    SELECT
        supplier_id,
        company_name,
        contact_name,
        contact_title,
        city,
        country,
        phone
    FROM {{ ref('stg_people__suppliers') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['supplier_id']) }} as supplier_key, 
    supplier_id,
    company_name AS supplier_name,
    contact_name AS supplier_contact,
    contact_title AS supplier_contact_title,
    city AS supplier_city,
    country AS supplier_country,
    phone AS supplier_phone
FROM supplier