

SELECT
  f.product_id,
  p.product_category_name_english,
  COUNT(order_id) AS order_count,
  ROUND(SUM(payment_value),2) AS total_revenue,
FROM `capstone-project-451604`.`capstone_dataset`.`fact_sales` as f JOIN `capstone-project-451604`.`capstone_dataset`.`dim_products` p on f.product_id = p.product_id
GROUP BY 1,2
ORDER BY total_revenue DESC
LIMIT 10