WITH orders AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        order_purchase_timestamp,
        order_delivered_customer_date AS order_delivered_timestamp,
        DATE_DIFF(order_delivered_customer_date, order_purchase_timestamp, day) AS days_to_deliver
    FROM `capstone-project-451604`.`capstone_dataset`.`stg_orders`
    WHERE DATE(order_purchase_timestamp) = '2025-03-02'
),

payments AS (
    SELECT
        order_id,
        payment_type,
        payment_installments,
        SUM(payment_value) AS payment_value
    FROM `capstone-project-451604`.`capstone_dataset`.`stg_order_payments`
    GROUP BY order_id, payment_type, payment_installments
),

order_items AS (
    SELECT
        order_id,
        product_id,
        seller_id,
        freight_value
    FROM `capstone-project-451604`.`capstone_dataset`.`stg_order_items`
),

customers AS (
    SELECT
        customer_id,
        customer_city,
        customer_state
    FROM `capstone-project-451604`.`capstone_dataset`.`stg_customers`
),

sellers AS (
    SELECT
        seller_id,
        seller_city,
        seller_state
    FROM `capstone-project-451604`.`capstone_dataset`.`stg_sellers`
)

SELECT
    o.order_id,
    o.customer_id,
    oi.product_id,
    oi.seller_id,
    o.order_purchase_timestamp,
    o.order_delivered_timestamp,
    o.days_to_deliver,
    o.order_status,
    p.payment_type,
    p.payment_installments,
    p.payment_value,
    oi.freight_value,
    c.customer_city,
    c.customer_state,
    s.seller_city,
    s.seller_state
FROM orders o
LEFT JOIN payments p ON o.order_id = p.order_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN sellers s ON oi.seller_id = s.seller_id