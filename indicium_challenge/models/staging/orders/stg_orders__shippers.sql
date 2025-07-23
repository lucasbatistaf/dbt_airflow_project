SELECT *
FROM {{ source('ORDERS', 'SHIPPERS') }}