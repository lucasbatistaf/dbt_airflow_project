{{ config(
    tags=['dimension']
) }}

WITH customers AS (
    SELECT
        num_customer_id,
        str_customer_id,
        company_name,
        contact_name,
        contact_title,
        country,
        city,
        address,
        phone
    FROM {{ ref('int_people__customers') }}
),

orders AS (
    SELECT
        order_id,
        customer_id
    FROM {{ ref('stg_orders__orders') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['c.num_customer_id', 'o.order_id']) }} as customer_key, 
    c.num_customer_id AS customer_id,    
    c.company_name,
    c.contact_name,
    c.contact_title,
    c.country,
    c.city,
    c.address,
    c.phone,
    o.order_id
FROM customers AS c
LEFT JOIN orders AS o
    ON c.str_customer_id = o.customer_id