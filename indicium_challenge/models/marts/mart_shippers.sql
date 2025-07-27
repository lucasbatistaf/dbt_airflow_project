{{ config(
    tags=['marts']
) }}

SELECT
    shipper_id,
    shipper_name,
    shipper_phone
FROM {{ ref('dim_shippers') }}