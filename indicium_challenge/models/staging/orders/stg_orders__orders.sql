SELECT *
FROM {{ source('ORDERS', 'ORDERS') }}