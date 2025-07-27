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
),

products AS (
    SELECT
        product_id,
        supplier_id
    FROM {{ ref('stg_products__products') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['s.supplier_id', 'p.product_id']) }} as supplier_key, 
    s.supplier_id,
    s.company_name,
    s.contact_name,
    s.contact_title,
    s.city,
    s.country,
    s.phone,
    p.product_id
FROM supplier AS s
LEFT JOIN products AS p 
    ON s.supplier_id = p.supplier_id