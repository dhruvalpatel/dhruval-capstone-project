{{ config(
    materialized='view'
) }}

SELECT
  seller_id,
  seller_city,
  seller_state,
  ROUND(SUM(payment_value),2) AS seller_revenue,
  COUNT(order_id) AS order_count
FROM {{ ref('fact_sales') }}
GROUP BY seller_id, seller_city, seller_state
ORDER BY seller_revenue DESC