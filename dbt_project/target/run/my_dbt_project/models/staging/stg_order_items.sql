

  create or replace view `capstone-project-451604`.`capstone_dataset`.`stg_order_items`
  OPTIONS()
  as with
    order_items as (
        select
            order_id,
            order_item_id,
            product_id,
            seller_id,
            shipping_limit_date,
            price,
            freight_value
        from `capstone-project-451604`.`capstone_dataset`.`order_items`
    )

select *
from order_items;

