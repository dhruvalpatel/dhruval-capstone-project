{{ config(
    materialized='view'
) }}

WITH monthly_sales AS (
  SELECT
    EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
    ROUND(SUM(payment_value),2) AS total_revenue
FROM {{ ref('fact_sales') }}
  GROUP BY month
)
SELECT
  month,
  total_revenue,
  LAG(total_revenue) OVER (ORDER BY month) AS prev_month_revenue,
  ROUND((total_revenue - LAG(total_revenue) OVER (ORDER BY month)) / LAG(total_revenue) OVER (ORDER BY month) * 100,2) AS growth_rate
FROM monthly_sales
ORDER BY month