{{ config(
    materialized='view'
) }}

SELECT
  f.product_id,
  p.product_category_name_english,
  COUNT(order_id) AS order_count,
  ROUND(SUM(payment_value),2) AS total_revenue,
FROM {{ ref('fact_sales') }} as f JOIN {{ ref('dim_products') }} p on f.product_id = p.product_id
GROUP BY 1,2
ORDER BY total_revenue DESC
LIMIT 10