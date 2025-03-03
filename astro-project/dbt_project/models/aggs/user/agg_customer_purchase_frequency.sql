{{ config(
    materialized='view'
) }}

SELECT
  customer_id,
  customer_city,
  customer_state,
  COUNT(order_id) AS order_count,
  ROUND(SUM(payment_value),2) AS total_spent
FROM {{ ref('fact_sales') }}
GROUP BY customer_id, customer_city, customer_state
HAVING order_count > 1
ORDER BY order_count DESC