{{ config(
    tags=['staging'],
    unique_key='category_id'
) }}

WITH source AS (
    SELECT
        category_id,
        category_name
    FROM {{ source('PRODUCTS', 'CATEGORIES') }}
)

SELECT *
FROM source