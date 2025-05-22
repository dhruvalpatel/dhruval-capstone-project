{{ config(
    materialized='view'
) }}

SELECT
  customer_city,
  customer_state,
  ROUND(AVG(payment_value),2) AS avg_order_value,
  COUNT(order_id) AS order_count
FROM {{ ref('fact_sales') }}
GROUP BY customer_city, customer_state
ORDER BY avg_order_value DESC