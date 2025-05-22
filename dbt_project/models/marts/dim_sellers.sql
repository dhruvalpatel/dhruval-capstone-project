{{ config(
    materialized='table',
    unique_key='seller_id'
) }}

SELECT
    seller_id,
    seller_city,
    seller_state,
    seller_zip_code_prefix
FROM {{ ref('stg_sellers') }}