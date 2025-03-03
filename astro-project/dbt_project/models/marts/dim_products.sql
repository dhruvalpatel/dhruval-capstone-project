{{ config(
    materialized='table',
    unique_key='product_id'
) }}

WITH products AS (
    SELECT
        product_id,
        product_category_name,
        product_weight_g,
        product_length_cm,
        product_height_cm,
        product_width_cm
    FROM {{ source('capstone_dataset', 'products') }}
),

category_translation AS (
    SELECT
        product_category_name AS original_category,
        product_category_name_english
    FROM {{ ref('stg_product_category_name_translation') }}
)

SELECT
    p.product_id,
    COALESCE(ct.product_category_name_english, p.product_category_name) AS product_category_name_english,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM products p
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.original_category