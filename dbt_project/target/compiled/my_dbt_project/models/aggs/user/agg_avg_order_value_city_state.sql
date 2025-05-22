

SELECT
  customer_city,
  customer_state,
  ROUND(AVG(payment_value),2) AS avg_order_value,
  COUNT(order_id) AS order_count
FROM `capstone-project-451604`.`capstone_dataset`.`fact_sales`
GROUP BY customer_city, customer_state
ORDER BY avg_order_value DESC