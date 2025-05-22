{{ config(
    materialized='view'
) }}

SELECT
  seller_id,
  seller_city,
  seller_state,
  AVG(days_to_deliver) AS avg_days_to_deliver,
  COUNT(order_id) AS order_count
FROM {{ ref('fact_sales') }}
WHERE order_status = 'delivered'
GROUP BY seller_id, seller_city, seller_state
ORDER BY avg_days_to_deliver DESC