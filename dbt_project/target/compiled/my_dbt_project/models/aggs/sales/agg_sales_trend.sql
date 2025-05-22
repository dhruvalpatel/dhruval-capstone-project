

SELECT
  EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
  EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
  ROUND(SUM(payment_value),2) AS total_revenue,
  COUNT(order_id) AS total_orders,
FROM `capstone-project-451604`.`capstone_dataset`.`fact_sales`
GROUP BY month, year
ORDER BY month, year