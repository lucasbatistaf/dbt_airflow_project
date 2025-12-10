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
    shipper_id,
    company_name AS shipper_name,
    phone AS shipper_phone
FROM shippers