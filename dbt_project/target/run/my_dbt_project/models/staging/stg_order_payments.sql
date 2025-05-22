

  create or replace view `capstone-project-451604`.`capstone_dataset`.`stg_order_payments`
  OPTIONS()
  as with
    order_payments as (
        select
            order_id,
            payment_sequential,
            payment_type,
            payment_installments,
            payment_value
        from `capstone-project-451604`.`capstone_dataset`.`order_payments`
    )

select *
from order_payments;

