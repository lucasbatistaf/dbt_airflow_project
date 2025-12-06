{{ config(
    tags=['dimension']
) }}

WITH shippers AS (
    SELECT
        shipper_id,
        company_name,
        phone
    FROM {{ ref('stg_people__shippers') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['s.shipper_id']) }} as shipper_key, 
    s.shipper_id,
    s.company_name AS shipper_name,
    s.phone AS shipper_phone
FROM shippers AS s