{{ config(
    materialized='view'
) }}

SELECT
  EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
  EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
  ROUND(SUM(payment_value),2) AS total_revenue,
  COUNT(order_id) AS total_orders,
FROM {{ ref('fact_sales') }}
GROUP BY month, year
ORDER BY month, year