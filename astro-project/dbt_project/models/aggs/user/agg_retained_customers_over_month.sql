{{ config(
    materialized='view'
) }}

WITH first_orders AS (
  SELECT
    customer_id,
    MIN(DATE(order_purchase_timestamp)) AS first_purchase_date
FROM {{ ref('fact_sales') }}
  GROUP BY customer_id
),
cohort_data AS (
  SELECT
    f.customer_id,
    f.first_purchase_date,
    EXTRACT(MONTH FROM s.order_purchase_timestamp) AS purchase_month,
    COUNT(s.order_id) AS order_count
  FROM first_orders f
  JOIN {{ ref('fact_sales') }} s
    ON f.customer_id = s.customer_id
  GROUP BY f.customer_id, f.first_purchase_date, purchase_month
)
SELECT
  first_purchase_date,
  purchase_month,
  COUNT(DISTINCT customer_id) AS retained_customers
FROM cohort_data
GROUP BY first_purchase_date, purchase_month
ORDER BY first_purchase_date, purchase_month