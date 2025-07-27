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
    {{ dbt_utils.generate_surrogate_key(['s.supplier_id']) }} as supplier_key, 
    s.supplier_id,
    s.company_name,
    s.contact_name,
    s.contact_title,
    s.city,
    s.country,
    s.phone
FROM supplier AS s