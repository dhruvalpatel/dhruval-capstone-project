{{ config(
    materialized='table',
    unique_key='customer_id',
    cluster_by = ['customer_city']
) }}

SELECT
    customer_id,
    customer_unique_id,
    customer_city,
    customer_state,
    customer_zip_code_prefix
FROM {{ source('capstone_dataset', 'customers') }}